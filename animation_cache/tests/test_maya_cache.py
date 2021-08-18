import os
import shutil
import logging
import unittest
import tempfile

import maya.cmds as mc
from maya import standalone


class testMayaCache(unittest.TestCase):
    def testCacheManagerExport(self):
        from animation_cache.maya.maya_cache_manager import MayaCacheManager
        from animation_cache.maya.maya_cache import MayaCacheFactory
        import animation_cache
        import pymel.core as pm

        exportPath = tempfile.mkdtemp()
        self.addCleanup(lambda: shutil.rmtree(exportPath, ignore_errors=True))
        cacheManager = MayaCacheManager()

        mc.file(os.path.abspath('resources/testAnimation.ma'), open=True, force=True)

        gpuCaches = [
            MayaCacheFactory.fromEntity(pm.ls(typ='gpuCache')[0])
        ]
        cameras = [
            MayaCacheFactory.fromEntity(pm.ls('testCameraShape', cameras=1)[0])
        ]
        references = [
            MayaCacheFactory.fromEntity(r) for r in pm.ls(references=1)
            if r.referenceFile() and r.parentReference()
        ]
        local = [
            MayaCacheFactory.fromEntity(pm.ls('localNodes'))
        ]

        cache = cameras+references+local+gpuCaches
        cacheManager.doExport(
            cache, directory=exportPath, operation=animation_cache.kOverwriteCache
        )
        exportedCache = MayaCacheFactory.fromFile(exportPath)
        self.assertEqual(len(exportedCache), len(cache), 'Cache count do not match!')
        mc.file(new=1, force=1)
        cacheManager.doImport(exportedCache)
        mc.file(new=1, force=1)

    @classmethod
    def setUpClass(cls):
        logging.basicConfig(
            level=logging.DEBUG,
            format="%(levelname)s: %(asctime)s %(name)s:%(message)s",
            datefmt="%Y-%m-%d %H:%M:%S"
        )
        logging.getLogger('animation_cache').setLevel(level=logging.DEBUG)
        standalone.initialize()

    @classmethod
    def tearDownClass(cls):
        standalone.uninitialize()


if __name__ == '__main__':
    unittest.main()
