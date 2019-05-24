# Copyright 2018 by Mikhail Pasechnik. All Rights Reserved.
#
# This library is free software: you can redistribute it and/or
# modify it under the terms of the GNU Lesser General Public
# License as published by the Free Software Foundation, either
# version 3 of the License, or (at your option) any later version.
# This library is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
# Lesser General Public License for more details.
# You should have received a copy of the GNU Lesser General Public
# License along with this library. If not, see <http://www.gnu.org/licenses/>.
"""Implements user interface for importing and exporting cache"""

import os
import re
import sys
import logging
import functools
from pprint import pformat

import animation_cache
from animation_cache.vendor.Qt import QtCore, QtGui, QtWidgets, QtUiTools

logger = logging.getLogger(__name__)


class CacheDialog(QtWidgets.QDialog):
    def __init__(self, cacheManager, operationType, cache=None, parent=None):
        super(CacheDialog, self).__init__(parent)
        self.setWindowFlags(self.windowFlags() | QtCore.Qt.Widget)
        self.tableColumns = ('Icon', 'Type', 'Name', 'Path')
        self._cache = []
        self._settings = None

        self.operationType = operationType
        self.cacheManager = cacheManager

        self.setupUi()

        # Connect signals and set defaults based on operation type
        self.searchEdit.textChanged.connect(self.filterCache)
        self.browseBtn.clicked.connect(self.selectCacheDirectory)
        self.refreshBtn.clicked.connect(self.refresh)

        settings = cacheManager.getDefaultSettings()

        if self.operationType == animation_cache.kExportCacheOp:
            self.cache = cache or []
            self.settings = settings

            self.doAllBtn.clicked.connect(self.doExport)
            self.doSelectedBtn.clicked.connect(lambda: self.doExport(self.getSelectedCache()))
            self.fStart.valueChanged.connect(lambda v: self._settings.__setitem__('fstart', v))
            self.fEnd.valueChanged.connect(lambda v: self._settings.__setitem__('fend', v))
            self.samples.valueChanged.connect(lambda v: self._settings.__setitem__('samples', v))
            self.padding.valueChanged.connect(lambda v: self._settings.__setitem__('padding', v))

        elif self.operationType == animation_cache.kImportCacheOp:
            self.cache = cache or []
            self.settings = settings
            self.doAllBtn.clicked.connect(self.doImport)
            self.doSelectedBtn.clicked.connect(lambda: self.doImport(self.getSelectedCache()))

        self.directory.textChanged.connect(self.onDirectoryChanged)

    def onDirectoryChanged(self, directory):
        self._settings.__setitem__('directory', directory)

    def doExport(self, cache=None):
        operation = animation_cache.kMergeCache
        if cache is None:
            cache = self.cache
            operation = animation_cache.kOverwriteCache

        logger.debug('doExport: settings: {} \ncache: \n{}'.format(
            pformat(self.settings), pformat(cache)
        ))
        result = self.cacheManager.doExport(
            cache=cache,
            force=True,
            operation=operation,
            **self.settings
        )
        self.onActionTriggered(zip(cache, result))

    def doImport(self, cache=None):
        if cache is None:
            cache = self.cache
        logger.debug('doImport: settings: {} \ncache: \n{}'.format(
            pformat(self.settings), pformat(cache)
        ))
        result = self.cacheManager.doImport(cache=cache, force=True)
        self.onActionTriggered(zip(cache, result))

    @property
    def settings(self):
        return self._settings

    @settings.setter
    def settings(self, value):
        self.directory.setText(value['directory'])
        self.fStart.setValue(value['fstart'])
        self.fEnd.setValue(value['fend'])
        self.samples.setValue(value['samples'])
        self.padding.setValue(value['padding'])
        self._settings = value

    def refresh(self):
        self.searchEdit.setText('')
        if self.operationType == animation_cache.kExportCacheOp:
            self.cache = self.cacheManager.getFactory().fromScene()
        if self.operationType == animation_cache.kImportCacheOp:
            self.cache = self.cacheManager.getFactory().fromFile(self.settings['directory'])

    def getSelectedCache(self):
        return [self.table.item(r, self.tableColumns.index('Name')).cache
                for r in self.getSelectedRows()]

    def getSelectedRows(self):
        return list(set(map(lambda i: i.row(), self.table.selectedIndexes())))

    @property
    def cache(self):
        return self._cache

    @cache.setter
    def cache(self, value):
        self.showCache(value)
        self._cache = value

    def getRow(self, c):
        for i in range(self.table.rowCount()):
            if self.table.item(i, self.tableColumns.index('Name')).cache == c:
                return i

    def setupUi(self):
        self.setAttribute(QtCore.Qt.WA_DeleteOnClose)
        self.setLayout(QtWidgets.QVBoxLayout())
        self.layout().setContentsMargins(0, 0, 0, 0)
        self.setMinimumSize(QtCore.QSize(820, 520))

        loader = QtUiTools.QUiLoader()
        uiFile = QtCore.QFile(os.path.splitext(__file__)[0] + '.ui')
        uiFile.open(QtCore.QFile.ReadOnly)
        loader.setWorkingDirectory(os.path.dirname(__file__))
        self.ui = loader.load(uiFile, self)
        self.layout().addWidget(self.ui)
        uiFile.close()

        self.directory = self.ui.directory
        self.browseBtn = self.ui.browseBtn
        self.doSelectedBtn = self.ui.doSelectedBtn
        self.doAllBtn = self.ui.doAllBtn
        self.refreshBtn = self.ui.refreshBtn

        self.fStart = self.ui.fStart
        self.fEnd = self.ui.fEnd
        self.samples = self.ui.samples
        self.padding = self.ui.padding

        self.searchEdit = self.ui.searchEdit
        self.table = self.ui.table
        self.table.setColumnCount(len(self.tableColumns))
        self.settingsLayout = self.ui.settingsLayout
        self.settingsLayout.setAlignment(QtCore.Qt.AlignRight)
        if self.operationType != animation_cache.kExportCacheOp:
            modeName = 'Export' \
                if animation_cache.kExportCacheOp == self.operationType \
                else 'Import'
            self.doAllBtn.setText(
                self.doAllBtn.text().replace('Export', modeName))
            self.doSelectedBtn.setText(
                self.doSelectedBtn.text().replace('Export', modeName))
            for sw in [self.settingsLayout.itemAt(i).widget() for i in
                       range(self.settingsLayout.count())]:
                sw.setEnabled(False)

        self.table.horizontalHeader().setDefaultSectionSize(32)
        try:
            self.table.horizontalHeader().setSectionResizeMode(
                1, QtWidgets.QHeaderView.ResizeToContents)
            self.table.horizontalHeader().setSectionResizeMode(
                2, QtWidgets.QHeaderView.ResizeToContents)
            self.table.horizontalHeader().setSectionResizeMode(
                3, QtWidgets.QHeaderView.Stretch
            )
        except AttributeError as e:  # NOTE: PySide
            self.table.horizontalHeader().setResizeMode(
                1, QtWidgets.QHeaderView.ResizeToContents)
            self.table.horizontalHeader().setResizeMode(
                2, QtWidgets.QHeaderView.ResizeToContents)
            self.table.horizontalHeader().setResizeMode(
                3, QtWidgets.QHeaderView.Stretch
            )
        self.table.verticalHeader().setDefaultSectionSize(32)
        self.table.setEditTriggers(QtWidgets.QAbstractItemView.NoEditTriggers)
        self.table.cellDoubleClicked.connect(
            lambda r, c: self.doubleClicked(
                self.table.item(r, self.tableColumns.index('Name')).cache)
        )
        self.table.setIconSize(QtCore.QSize(32, 32))

    def doubleClicked(self, cache):
        pass

    def filterCache(self, text):
        """Filter assets displayed by currently selected asset type."""
        rowCount = self.table.rowCount()
        if text:
            for i in range(rowCount):
                tableItem = self.table.item(
                    i,
                    self.tableColumns.index('Name')
                )
                if bool(re.match(r'(.+|^)%s' % text, tableItem.text())):
                    self.table.setRowHidden(i, False)
                else:
                    self.table.setRowHidden(i, True)
        else:
            for i in range(rowCount):
                self.table.setRowHidden(i, False)

        return True

    def selectCacheDirectory(self):
        selected_directory = QtWidgets.QFileDialog.getExistingDirectory(
            dir=self.directory.text(),
            options=QtWidgets.QFileDialog.IgnoreMask
        )
        if selected_directory != '':
            self.directory.setText(selected_directory.replace('\\', '/'))

    def showCache(self, cache):
        while self.table.rowCount() > 0:
            self.table.removeRow(0)
        self.table.clearContents()
        self.table.setRowCount(len(cache))

        for i, c in enumerate(cache):
            self.createItems(i, c)
        self.table.setFocus()

    def createItems(self, row, c):
        column = self.tableColumns.index
        nameItem = QtWidgets.QTableWidgetItem(self.getName(c))
        nameItem.cache = c
        self.table.setItem(row, column('Name'), nameItem)
        typeItem = QtWidgets.QTableWidgetItem(c.type)
        self.table.setItem(row, column('Type'), typeItem)

        if self.operationType == animation_cache.kImportCacheOp:
            importVariants = self.getImportVariants(c)
            customFile = QtWidgets.QPushButton('+')
            customFile.setFocusPolicy(QtCore.Qt.NoFocus)
            customFile.setFixedWidth(25)

            variants = QtWidgets.QComboBox()

            customFile.clicked.connect(functools.partial(self.selectFile, variants))

            widget = QtWidgets.QWidget(self.table)
            widget.setLayout(QtWidgets.QHBoxLayout())
            widget.layout().addWidget(variants)
            widget.layout().addWidget(customFile)
            widget.layout().setContentsMargins(0, 0, 0, 0)
            self.table.setCellWidget(
                row, column('Path'), widget
            )

            variants.addItems(importVariants)
            if importVariants:
                variants.setToolTip(importVariants[0])

            variants.currentIndexChanged.connect(
                functools.partial(
                    self.onImportVariantChanged, c, variants
                )
            )
        elif self.operationType == animation_cache.kExportCacheOp and c.get('path'):
            pathItem = QtWidgets.QTableWidgetItem(c.get('path'))
            self.table.setItem(row, column('Path'), pathItem)

        icon = self.getIcon(c)
        if icon:
            assetThumbnail = QtWidgets.QTableWidgetItem()
            assetThumbnail.setSizeHint(QtCore.QSize(32, 32))
            assetThumbnail.setIcon(icon)
            self.table.setItem(
                row, self.tableColumns.index('Icon'), assetThumbnail
            )

    def getName(self, cache):
        return cache['name']

    def getImportVariants(self, cache):
        return cache.importVariants

    def getPath(self, cache):
        return cache.get('path')

    def getIcon(self, cache):
        pass

    @staticmethod
    def onImportVariantChanged(c, comboBox, index):
        c.importVariants = [
            comboBox.itemText(i) for i in
            sorted(range(comboBox.count()), key=lambda ii: ii == index, reverse=True)
        ]
        comboBox.setToolTip(comboBox.itemText(index))

    @staticmethod
    def selectFile(comboBox):
        selectedFile = \
            QtWidgets.QFileDialog.getOpenFileName(
                dir=comboBox.itemText(comboBox.currentIndex()))[0]
        if len(selectedFile) is not 0:
            comboBox.blockSignals(True)
            comboBox.insertItem(0, selectedFile)
            comboBox.blockSignals(False)
            comboBox.setCurrentIndex(0)

    def onActionTriggered(self, result):
        for c, r in result:
            if isinstance(r, Exception):
                color = QtCore.Qt.darkRed
            else:
                color = QtCore.Qt.darkGreen
            row = self.getRow(c)
            if row is not None:
                for i in range(len(self.tableColumns)):
                    item = self.table.item(row, i)
                    if item:
                        item.setBackground(QtGui.QBrush(color))


def showDialog(cacheManager, operationType, cache, parent=None, class_=CacheDialog):
    assert class_ is None or issubclass(class_, CacheDialog),\
        "class_ %s must be subclass of CacheDialog" % class_
    app = None
    if not QtWidgets.QApplication.instance():
        app = QtWidgets.QApplication(sys.argv)
    w = class_(cacheManager, operationType, cache, parent)
    w.show()
    if app:
        sys.exit(app.exec_())
    return w
