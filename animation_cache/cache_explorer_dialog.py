import sys
import os
import imath
from alembic import Abc, AbcGeom

try:
    from PySide.QtCore import *
    from PySide.QtGui import *
except:
    from PySide2.QtWidgets import *
    from PySide2.QtCore import *
    from PySide2.QtGui import *

kWrapExisting = Abc.WrapExistingFlag.kWrapExisting


class SampleTreeWidgetItem(QTreeWidgetItem):
    def __init__(self, index, sample, prop=None, parent=None):
        """
        :param index: Sample index value
        :param sample: Alembic Sample object
        :param prop: PropertyTreeWidgetItem object
        """
        super(SampleTreeWidgetItem, self).__init__(parent)
        self.property = prop
        self.sample = sample

        self.setText(0, index)
        self.setText(1, self.length())
        self.setText(2, self.value())
        if self.property and (
                self.property.isArray() or
                type(self.sample) == imath.DoubleArray
            ):
            i = 0
            for s in self.sample:
                ii = SampleTreeWidgetItem(i, s, None)
                self.addChild(
                    ii
                )
                i += 1
                if i > AlembicFileExplorer.limit:
                    break
            self.setExpanded(True)

    def value(self):
        if self.property and self.property.isArray():
            return type(self.sample).__name__
        return self.sample

    def setText(self, i, t):
        super(SampleTreeWidgetItem, self).setText(i, str(t).replace('), ', '),\n    ').
                                                            replace('))', ')\n)').
                                                            replace('((', '(\n    ('))

    def length(self):
        if self.property and self.property.isScalar():
            return self.property.getDataType().getExtent()
        elif self.property:
            return len(self.sample)
        return ''


class PropertyTreeWidgetItem(QTreeWidgetItem):
    def __init__(self, prop, parent=None):
        """
        :param prop: IArray or IScalar Property object
        """
        super(PropertyTreeWidgetItem, self).__init__(parent)
        self.property = prop

        if self.property.isCompound():
            self.setChildIndicatorPolicy(QTreeWidgetItem.ShowIndicator)
        else:
            self.setChildIndicatorPolicy(QTreeWidgetItem.DontShowIndicator)

        self.setText(0, self.property.getName())
        self.setText(1, self.type())
        self.setText(2, self.property.getDataType())
        self.setText(3, self.isConstant())
        self.setToolTip(0, self.property.getName())
        self.setForeground(0, QBrush(QColor('green' if not self.isConstant() else 'black')))
        for p in self.properties(self.property):
            i = PropertyTreeWidgetItem(p)
            self.addChild(i)
            i.setExpanded(True)

    def setText(self, i, t):
        super(PropertyTreeWidgetItem, self).setText(i, str(t))

    @staticmethod
    def properties(prop):
        if not prop.isCompound():
            return []
        return [prop.getProperty(header.getName()) for header in prop.propertyheaders]

    def type(self):
        if self.property.isCompound():
            return 'compound'
        elif self.property.isScalar():
            return 'scalar'
        elif self.property.isArray():
            return 'array'
        else:
            return 'unknown'

    def isConstant(self):
        if self.property.isCompound():
            return False
        return self.property.isConstant()

    def samples(self):
        if self.property.isCompound():
            return []
        else:
            return self.property.samples


class AlembicFileExplorer(QWidget):
    limit = 300

    def __init__(self, parent=None):
        super(AlembicFileExplorer, self).__init__(parent=parent)
        self.gpuCache = None
        self.topLevelItems = []
        self.setAcceptDrops(True)

        self.setWindowTitle('Alembic File Explorer - drop file in window to begin.')
        self.setWindowFlags(self.windowFlags() | Qt.Widget)
        self.setAttribute(Qt.WA_DeleteOnClose)
        self.mainLayout = QGridLayout(self)
        self.mainLayout.setContentsMargins(0, 0, 0, 0)

        self.treeView = QTreeWidget(self)
        self.treeView.setColumnCount(1)
        self.treeView.setHeaderLabels(['Name', 'Type'])
        self.treeView.header().resizeSection(0, 200)
        self.treeView.currentItemChanged.connect(self.onAbcItemChanged)
        self.mainLayout.addWidget(self.treeView, 0, 0)

        self.propTree = QTreeWidget(self)
        self.propTree.setColumnCount(4)
        self.propTree.setHeaderLabels(['name', 'type', 'data_type', 'is_constant'])
        self.propTree.currentItemChanged.connect(self.onPropSelect)
        self.mainLayout.addWidget(self.propTree, 0, 1)

        self.valTree = QTreeWidget(self)
        self.valTree.setColumnCount(3)
        self.valTree.setHeaderLabels(['index', 'size', 'value'])
        self.mainLayout.addWidget(self.valTree, 1, 0)

        self.info = QTextEdit(self)
        self.info.setTabStopWidth(4)
        self.mainLayout.addWidget(self.info,1 , 1)

        self.limit = QSpinBox(self)
        self.limit.setMaximum(999999)
        self.limit.setValue(300)
        self.limit.setMinimum(0)
        self.limit.valueChanged.connect(lambda v: setattr(AlembicFileExplorer, 'limit', v))
        self.mainLayout.addWidget(self.limit, 2, 0)

    def onPropSelect(self, current, previous):
        if not current:
            return
        self.valTree.clear()
        i = 0
        for s in current.samples():
            self.valTree.addTopLevelItems([
                SampleTreeWidgetItem(
                    i, s, current.property
                )
            ])
            i += 1
            if i > AlembicFileExplorer.limit or current.property.isConstant():
                break

    def populateTreeView(self, top):
        self.treeView.clear()
        self.topLevelItems = []
        if not top:
            return
        items = list(zip([None] * len(top.children), top.children))

        while items:
            parent, child = items.pop(0)
            item = QTreeWidgetItem([child.getName(), self.getType(child)])
            item.abcIObject = child
            item.setForeground(0, QBrush(QColor(self.getForegroundColor(item))))
            items.extend(zip([item] * len(child.children), child.children))
            if parent is not None:
                parent.addChild(item)
            else:
                self.topLevelItems.append(item)
        self.treeView.addTopLevelItems(self.topLevelItems)
        self.treeView.clearSelection()

    def onAbcItemChanged(self, current, previous):
        if not current:
            return
        self.propTree.clear()
        topLevelItems = []
        props = current.abcIObject.getProperties()
        for h in props.propertyheaders:
            topLevelItems.append(
                PropertyTreeWidgetItem(props.getProperty(h.getName()))
            )
        self.propTree.addTopLevelItems(topLevelItems)
        for i in topLevelItems:
            i.setExpanded(True)
        self.info.setHtml(
            self.getAbcObjectInfo(current.abcIObject)
        )

    def getForegroundColor(self, item):
        color = 'gray'
        typed = self.getTyped(item.abcIObject)
        if not typed:
            return color
        numSamples = typed.getSchema().getNumSamples()
        if not numSamples:
            return color
        elif numSamples == 1:
            return 'black'
        else:
            return 'green'

    @staticmethod
    def getType(iObject):
        if AbcGeom.IXform.matches(iObject.getMetaData()):
            return 'Xform'
        elif AbcGeom.IPolyMesh.matches(iObject.getMetaData()):
            return 'PolyMesh'
        return ''

    @staticmethod
    def getTransformOps(transform):
        ops = []

        transformSchema = transform.getSchema()
        numOps = transformSchema.getNumOps()
        if numOps > 0 and not transformSchema.isConstant():
            value = transformSchema.getValue()
            for i in range(numOps):
                op = value.getOp(i)

                if op.isAngleAnimated() and not op.isRotateOp():
                    if op.isRotateXOp():
                        rotateAxis = 'X'
                    elif op.isRotateYOp():
                        rotateAxis = 'Y'
                    elif op.isRotateZOp():
                        rotateAxis = 'Z'
                    ops.append(('rotate', rotateAxis))

                elif op.isTranslateOp() or op.isScaleOp():
                    if op.isTranslateOp():
                        opName = 'translate'
                    else:
                        opName = 'scale'

                    if op.isXAnimated():
                        ops.append((opName, 'X'))
                    if op.isYAnimated():
                        ops.append((opName, 'Y'))
                    if op.isZAnimated():
                        ops.append((opName, 'Z'))

                elif op.isMatrixOp():
                    for cNum in range(op.getNumChannels()):
                        if op.isChannelAnimated(cNum):
                            ops.append(('matrix', None))

                elif op.isRotateOp():
                    for cNum in range(op.getNumChannels()):
                        if op.isChannelAnimated(cNum):
                            ops.append(('quaternion', None))
        return ops

    @staticmethod
    def getTyped(iObject):
        typed = None
        if AbcGeom.IXform.matches(iObject.getMetaData()):
            typed = AbcGeom.IXform(iObject, kWrapExisting)
        elif AbcGeom.IPolyMesh.matches(iObject.getMetaData()):
            typed = AbcGeom.IPolyMesh(iObject, kWrapExisting)

        if not typed:
            return
        return typed

    def getAbcObjectInfo(self, iObject):
        typed = self.getTyped(iObject)
        if not typed:
            return ''

        schema = typed.getSchema()
        typeName = self.getType(iObject)
        info = []
        info.extend([
            ('Name:', typed.getName()),
            ('FullName:', typed.getFullName()),
            ('Type:', typeName),
            ('NumSamples:', schema.getNumSamples()),
        ])

        if typeName == 'Xform':
            info.extend([
                ('NumOps: ', schema.getNumOps()),
            ])

            for p in self.getTransformOps(typed):
                info.extend([
                    ('TransformOps: ', str(p[0]) + str(p[1])),
                ])

        visP = AbcGeom.GetVisibilityProperty(typed)
        if visP:
            info.extend([
                ('VisibilityProperty: Sampled: ', not visP.isConstant()),
            ])

        arbP = schema.getArbGeomParams()

        if arbP:
            for i in range(arbP.getNumProperties()):
                head = arbP.getPropertyHeader(i)
                pr = arbP.getProperty(i)

                info.extend([
                    ('ArbGeomParams: Class:' + str(pr.__class__.__name__) + ': ' + head.getName() + ': Sampled:', not pr.isConstant()),
                ])

        html = ''
        for i in info:
            html += '<p><i style="color: gray">{}</i> {}</p>'.format(i[0], i[1])
        return html

    @staticmethod
    def getTop(path):
        archive = Abc.IArchive(str(os.path.expandvars(path)))
        return archive.getTop()

    def dragEnterEvent(self, event):
        if event.mimeData().hasUrls():
            event.accept()
        else:
            event.ignore()

    def dragMoveEvent(self, event):
        if event.mimeData().hasUrls():
            event.accept()
        else:
            event.ignore()

    def dropEvent(self, event):
        path = event.mimeData().urls()[0].toLocalFile()
        path = str(path).replace('/', '\\')
        self.populateTreeView(self.getTop(path))


def show(parent=None):
    app = None
    if not QApplication.instance():
        app = QApplication(sys.argv)
    w = AlembicFileExplorer(parent)
    w.show()
    if app:
        sys.exit(app.exec_())
    return w
