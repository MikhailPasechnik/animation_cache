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
"""Implements maya cache and cache factory based on base implementation"""

import os
import re
import json
import logging
import traceback
import contextlib
import collections

import maya.cmds as mc
import pymel.core as pm
import maya.mel as mm
from alembic import Abc, AbcGeom

import animation_cache
import animation_cache.utils
from animation_cache.cache import Cache, CacheFactory, CacheImporter
import animation_cache.alembic_utils as alembic_utils


logger = logging.getLogger(__file__)


class MayaCacheFactory(CacheFactory):
    """Maya cache factory

    Used for creating cache instances from various sources
    such as current scene or exported data.
    Cache manager uses it to populate cache in gui mode and
    when doExport or doImport called without 'cache' argument to populate cache.
    """

    @classmethod
    def fromData(cls, data, directory):
        """Returns cache instances from exported data

        :param data: cache data writen by cache class in export process
        :param directory: since additional files location may change this argument is necessary
        """
        cache = None
        if data['type'] == 'alembic':
            cache = AlembicCacheImporter(**data)
        elif data['type'] == 'gpuCache':
            cache = GpuCacheImporter(**data)
        elif data['type'] == 'reference':
            cache = ReferenceCacheImporter(**data)
        elif data['type'] == 'camera':
            cache = CameraCacheImporter(**data)

        if isinstance(cache, AlembicCacheImporter):
            sourceAlembic = preparePath(os.path.join(directory, cache['alembicFileName']))
            cache['sourceAlembic'] = sourceAlembic

        if isinstance(cache, GpuCacheImporter):
            cache.importVariants.append(preparePath(cache['path']))
        elif isinstance(cache, AlembicCacheImporter):
            cache.importVariants.append(cache['sourceAlembic'])

        return cache

    @classmethod
    def fromEntity(cls, entity):
        """Returns cache instances from entity such as maya node or array of nodes"""
        cache = None
        if hasattr(entity, 'nodeType'):
            nodeType = entity.nodeType()

            if nodeType == 'reference':
                cache = ReferenceCache(reference=entity)
            elif nodeType == 'gpuCache':
                cache = GpuCache(node=entity)
            elif nodeType == 'camera':
                cache = CameraCache(camera=entity)
            else:
                cache = AlembicCache(
                    nodes=[entity],
                    name=entity.namespace().replace(':', '_')
                )
        elif isinstance(entity, collections.Iterable):
            if entity and hasattr(entity[0], 'nodeType'):
                cache = AlembicCache(
                    nodes=entity,
                    name=entity[0].namespace().replace(':', '_') or entity[0].name().replace(':', '_')
                )
        return cache

    @classmethod
    def fromScene(cls):
        """Returns cache instances from current scene"""
        raise NotImplementedError

# ---------
#   Cache
# ---------


class AlembicCache(Cache):
    """Base class for alembic cache.

    Implements maya nodes hierarchy alembic cache.
    """
    type = 'alembic'
    alembicFileNameKey = 'alembicFileName'

    def __init__(self, nodes=None,
                 alembicFileName=None, alembicJobKwargs=None,
                 alembicJobArgs=None, **data):
        super(AlembicCache, self).__init__(**data)
        self.nodes = nodes
        self.alembicFileName = alembicFileName
        self.alembicJobArgs = alembicJobArgs or []
        self.alembicJobKwargs = alembicJobKwargs or dict(
            worldSpace=True,
            uvWrite=True,
            writeUVSets=True,
            writeVisibility=True,
        )

    def getNodes(self):
        return self.nodes

    def write(self, directory, fstart, fend, samples=1.0, padding=4, roots=None, **kwargs):
        nodes = self.getNodes()
        assert nodes, 'No nodes given'
        self.alembicFileName = self.alembicFileName or kwargs.get(
            'alembicFileName', self['name'] + '.abc'
        )
        # Alembic export job arguments that will be used to export alembic
        roots = roots or getRoots(nodes)
        assert roots, 'No transforms given'

        # Check roots for duplicates
        names = [r.name() for r in roots]
        assert len(set(names)) == len(names), 'Roots with duplicated names'
        self.alembicJobKwargs['f'] = preparePath(os.path.join(directory, self.alembicFileName))
        for k, v in dict(
            root=[r.longName() for r in roots],
            fr=[fstart-padding, fend+padding],
            step=samples,
        ).items():
            self.alembicJobKwargs.setdefault(k, v)

        self[self.alembicFileNameKey] = self.alembicFileName

        # If not batch abc export do export in place
        if not kwargs.get('batchAbcExport'):
            alembicJobKwargs = {}
            alembicJobArgs = []
            alembicJobKwargs.update(self.alembicJobKwargs)
            alembicJobArgs.extend(self.alembicJobArgs)
            for k, v in kwargs.get('alembicJobKwargs', dict()).items():
                alembicJobKwargs[k] = v
            for k, v in kwargs.get('alembicJobArgs', list()):
                alembicJobArgs.append((k, v))

            alembicFile = os.path.join(directory, self.alembicFileName)
            d = os.path.dirname(alembicFile)
            if not os.path.isdir(d):
                animation_cache.utils.makeDirs(d)
            mm.eval('{} {}'.format(
                kwargs.get('exportCommand', 'AbcExport'),
                alembic_utils.createAbcExportMelJob(
                    *alembicJobArgs, **alembicJobKwargs
                )
            ))
            self['files'].append(alembicFile)

        return super(AlembicCache, self).write(directory, fstart, fend,
                                               samples, padding, **kwargs)


class GpuCache(AlembicCache):
    """Maya Gpu Cache cache.

    Exports flat hierarchy alembic cache for each gpu cache node in scene,
    which cacheFileName is the same as initially provided gpu cache node.
    Imports each cached node as instance.
    """
    type = 'gpuCache'

    def __init__(self, node, name=None, nodes=None, **data):
        self['path'] = node.cacheFileName.get()
        if not name:
            name = node.namespace()
            if name == ':' or not name:
                name = node.name()
        nodes = nodes or [
            n for n in pm.ls(typ='gpuCache')
            if n.cacheFileName.get() == node.cacheFileName.get()
        ]
        super(GpuCache, self).__init__(name=name.replace(':', '_'), nodes=nodes, **data)

    @staticmethod
    def getRoots(nodes):
        allPaths = []
        for g in nodes:
            allPaths.extend(g.getAllPaths())
        return [n.getTransform() for n in allPaths]

    def write(self, directory, fstart, fend, samples=1, padding=4, **kwargs):
        allPaths = []
        for g in self.nodes:
            allPaths.extend(g.getAllPaths())

        return super(GpuCache, self).write(
            directory, fstart, fend, samples, padding,
            roots=[n.getTransform() for n in allPaths], **kwargs
        )


class ReferenceCache(AlembicCache):
    """Maya Reference cache

    Exports reference hierarchy to an alembic cache.
    """
    type = 'reference'

    def __init__(self, reference, name=None, **data):
        """
        :type reference: pm.
        :param data:
        """
        super(ReferenceCache, self).__init__(
            name=name or reference.associatedNamespace(False).replace(':', '_'),
            **data
        )
        self.reference = reference
        self['path'] = self.reference.referenceFile().path

    def getNodes(self):
        nodes = self.reference.nodes()
        for child_ref in pm.referenceQuery(self.reference, referenceNode=True, child=True) or []:
            nodes.extend(pm.ls(child_ref, references=True)[0].nodes())
        return nodes

    def write(self, directory, fstart, fend, samples=1, padding=4, **kwargs):
        self.nodes = self.getNodes()
        return super(ReferenceCache, self).write(
            directory, fstart, fend, samples, padding, **kwargs
        )


class CameraCache(AlembicCache):
    """Camera cache"""
    type = 'camera'

    def __init__(self, camera, name=None, alembicJobArgs=None, **data):
        if not (camera or name):
            raise TypeError('Not enough arguments, camera or name is required')
        alembicJobArgs = (alembicJobArgs or []) + [
            ('userAttr', 'shakeEnabled'),
            ('userAttr', 'horizontalShake'),
            ('userAttr', 'verticalShake'),
        ]
        super(CameraCache, self).__init__(
            name=name or camera.name().replace(':', '_'), nodes=[camera],
            alembicJobArgs=alembicJobArgs, **data
        )

# -------------------
#   Cache Importers
# -------------------


class AlembicCacheImporter(CacheImporter):
    def import_(self, **kwargs):
        assert self.importVariants or kwargs.get('path'), 'Nothing to import!'
        path = kwargs.get('path', self.importVariants[0])
        if not pm.pluginInfo('AbcImport', loaded=1, q=1):
            pm.loadPlugin('AbcImport')
        namespace = kwargs.get('namespace', self['name'])
        postfix = 0
        while mc.namespace(exists=namespace+str(postfix or '')) or \
                pm.ls(namespace+str(postfix or '')):
            postfix += 1
        namespace = namespace+str(postfix or '')
        reference = pm.createReference(
            preparePath(path),
            namespace=namespace,
            groupReference=kwargs.get('groupReference', True),
            groupName=kwargs.get('groupName', namespace + '_group'),
            force=True,
            prompt=False,
            reference=True,
            sharedNodes=[],
            defaultNamespace=False,
            lockReference=False,
        )
        return reference


class GpuCacheImporter(AlembicCacheImporter):
    def import_(self, **kwargs):
        alembicReference = super(GpuCacheImporter, self).import_(
            path=self.get('sourceAlembic'), groupReference=False, **kwargs
        )
        assemblies = pm.ls(alembicReference.refNode.nodes(), transforms=1)

        for i, a in enumerate(assemblies):
            namespace = alembicReference.refNode.associatedNamespace(False) + str(i or '')
            reference = pm.createReference(
                preparePath(self.importVariants[0]),
                namespace=namespace,
                groupReference=kwargs.get('groupReference', True),
                groupName=kwargs.get('groupName', namespace + '_group'),
                force=True,
                prompt=False,
                reference=True,
                sharedNodes=[],
                defaultNamespace=False,
                lockReference=False,
            )
            pm.parent(reference.refNode.associatedNode.get()[0], a, r=1)
        return alembicReference


class ReferenceCacheImporter(AlembicCacheImporter):
    def import_(self, **kwargs):
        reference = super(ReferenceCacheImporter, self).import_(**kwargs)

        if self.get('sourceAlembic') and self.importVariants[0] != self.get('sourceAlembic'):
            connectAlembic(
                self.get('sourceAlembic'),
                reference.refNode.associatedNode.get() or
                getRoots(reference.refNode.nodes()),
                reference.refNode.associatedNamespace(False)
            )
        return reference


class CameraCacheImporter(AlembicCacheImporter):
    def import_(self, **kwargs):
        reference = super(CameraCacheImporter, self).import_(
            namespace='camera',
            groupReference=False,
            **kwargs
        )
        for c in pm.ls(reference.refNode.nodes(), cameras=True):
            for a in 'tx|ty|tz|sx|sy|sz|rx|ry|rz'.split('|'):
                getattr(c.getTransform(), a).__apimplug__().setLocked(True)
        return reference

# ---------
#   Utils
# ---------


@contextlib.contextmanager
def namespaceContext(name):
    """Creates namespace if needed and sets current to it. Sets initial namespace of exit"""
    initial = pm.namespaceInfo(cur=True)
    pm.namespace(setNamespace=':')
    if pm.namespace(ex=name):
        pm.namespace(setNamespace=name)
    else:
        pm.namespace(add=name)
        pm.namespace(setNamespace=name)
    try:
        yield name
    except Exception:
        raise
    finally:
        pm.namespace(setNamespace=':')
        pm.namespace(setNamespace=initial)


def preparePath(path):
    return path.replace('\\', '/')


def connectAlembic(alembicFile, roots, namespace=':'):
    """Connects alembic cache to an hierarchy

    # TODO: Currently blend shape is used and the process is messy and not reliable
    """
    # Read archive and find all deformed geometry
    meshTransforms = []
    excludeFilter = []
    for g in alembic_utils.listArchive(Abc.IArchive(str(alembicFile)), AbcGeom.IPolyMesh):
        tName = g.getParent().getName().split(':')[-1]
        gName = g.getName().split(':')[-1]
        # Determine what to import from alembic based on shape name and is deformations present
        if g.getSchema().isConstant() and not gName == tName + 'ShapeDeformed':
            excludeFilter.append(g.getParent().getFullName() + '/')
        else:
            meshTransforms.extend(pm.ls(namespace + ':' + tName, transforms=True))

    excludeFilter = ' '.join(excludeFilter)
    # Do alembic cache import
    with namespaceContext(namespace):
        # NOTE: Unlock reference transforms attributes if locked
        #       as alembic will automatically create connections for transforms in hierarchy below
        for c in roots + pm.listRelatives(roots, allDescendents=True, typ='transform'):
            for a in 'tx|ty|tz|sx|sy|sz|rx|ry|rz'.split('|'):
                getattr(c, a).__apimplug__().setLocked(False)

        pm.mel.AbcImport(
            str(preparePath(alembicFile).replace('\\', '/')),
            ct=[r.longName() for r in roots],
            excludeFilterObjects=excludeFilter,
            # HACK: Create deformed geometry to make out
            #       poly plug evaluate its data as there is a bug
            crt=True
        )

        # Connect alembic cache with blendShape on to target geometry
        for t in meshTransforms:
            if len(t.getShapes()) == 1:
                logger.warn(
                    'Failed to connect cache for {} '
                    'there is not deformed shape'.format(t.longName())
                )
                continue
            destinationMeshPlug = t.getShape().inMesh
            deformedShape = t.getShapes()[1]
            if deformedShape.inMesh.listConnections(p=1):
                sourceMeshPlug = deformedShape.inMesh.listConnections(p=1)[0]
            else:
                sourceMeshPlug = deformedShape.outMesh
                deformedShape.intermediateObject.set(1)
                for sp, dp in deformedShape.outputs(p=1, c=1):
                    if dp.node().nodeType() == 'shadingEngine':
                        sp.disconnect(dp)
            try:
                blendShape = pm.deformer(destinationMeshPlug.node(), type='blendShape', before=True)[0]
                pm.connectAttr(
                    sourceMeshPlug,
                    blendShape.inputTarget[0].inputTargetGroup[0].inputTargetItem[6000].inputGeomTarget
                )
                blendShape.weight[0].set(1)
            except Exception as e:
                logger.debug('Failed to connect cache for {} exception: {}'.format(
                    t.longName(), traceback.format_exc()
                ))
                pass

        # NOTE: Force refresh
        # TODO: Can pm.refresh be used?
        pm.currentTime(pm.playbackOptions(q=True, animationStartTime=True) + 1)
        pm.currentTime(pm.playbackOptions(q=True, animationStartTime=True) - 1)

        alembicNodes = pm.ls(regex=re.escape(namespace) + ':.+', typ='AlembicNode')
        # Geometry Cache is not static
        if alembicNodes:
            # NOTE: Delete shapes created by alembic
            #       as we connected outMeshData directly in too blend shape
            for i in alembicNodes[0].outPolyMesh.getArrayIndices():
                pm.delete(pm.listConnections(alembicNodes[0].outPolyMesh[i], shapes=True, t='mesh'))
        return alembicNodes


def getRoots(nodes):
    transforms = set()
    for n in nodes:
        if n.nodeType() == 'transform':
            transforms.add(n)
        elif hasattr(n, 'getTransform'):
            try:
                transforms.add(n.getTransform())
            except TypeError:
                logger.warn(traceback.format_exc())
                logger.debug('Failed to add nodes transforms {}'.format(n))
    roots = []
    for t in transforms:
        isRoot = True
        for p in t.getAllParents():
            if p in transforms:
                isRoot = False
                break
        if isRoot and t not in roots:
            roots.append(t)
    return roots
