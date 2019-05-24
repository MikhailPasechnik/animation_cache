import pymel.core as pm
import animation_cache as ac
from animation_cache.maya import MayaCacheFactory, MayaCacheManager


class SimpleCacheManager(MayaCacheManager):
    @staticmethod
    def getDefaultExportPath():
        return MayaCacheManager.getDefaultExportPath()


class SimpleCacheFactory(MayaCacheFactory):
    @classmethod
    def fromScene(cls):
        """Returns cache instances from current scene"""
        cache = []
        # References
        for ref in pm.ls(references=1):
            refFile = ref.referenceFile()
            if refFile and not refFile.subReferences() \
                    and pm.ls(refFile.refNode.nodes(), et='mesh'):
                c = cls.fromEntity(refFile.refNode)
                if c:
                    cache.append(c)

        # Cameras
        for cam in pm.ls(et='camera'):
            if not cam.isReferenced() and \
                    cam.name() not in ['topShape', 'frontShape', 'sideShape', 'perspShape']:
                c = cls.fromEntity(cam)
                if c:
                    cache.append(c)

        # Gpu cache
        gpuCacheLocations = set()
        for gpuCache in pm.ls(typ='gpuCache'):
            if not gpuCache.isReferenced() \
                    and gpuCache.cacheFileName.get() not in gpuCacheLocations:
                gpuCacheLocations.add(gpuCache.cacheFileName.get())
                c = cls.fromEntity(gpuCache)
                if c:
                    cache.append(c)

        return cache

    @classmethod
    def fromFile(cls, directory, dataFile=None):
        return super(SimpleCacheFactory, cls).fromFile(directory, dataFile)


def showExportDialog():
    cacheManager = SimpleCacheManager(factory=SimpleCacheFactory)
    cacheManager.showGui(ac.kExportCacheOp, cache=SimpleCacheFactory.fromScene())


def showImportDialog():
    cacheManager = SimpleCacheManager(factory=SimpleCacheFactory)
    cacheManager.showGui(ac.kImportCacheOp,
                         cache=SimpleCacheFactory.fromFile(cacheManager.getDefaultExportPath()))
