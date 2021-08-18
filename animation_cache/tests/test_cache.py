import os
import shutil
import logging
import unittest
import tempfile


from animation_cache.cache_manager import CacheManager
from animation_cache.cache import CacheFactory, CacheImporter

logger = logging.getLogger(__name__)


class testMayaCache(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        logging.basicConfig(
            level=logging.DEBUG,
            format="%(levelname)s: %(asctime)s %(name)s:%(message)s",
            datefmt="%Y-%m-%d %H:%M:%S"
        )

    def testCacheManagerExport(self):
        exportPath = tempfile.mkdtemp()
        self.addCleanup(lambda: shutil.rmtree(exportPath, ignore_errors=True))
        cacheManager = CacheManager()

        cache = [
            CacheFactory.fromEntity({'myData': [1, 2, 3], 'name': 'myCache'})
        ]
        logger.debug('cache: {}'.format(cache))
        exportedCache = cacheManager.doExport(
            cache,
            exportPath,
            0, 0
        )
        self.assertEqual(len(exportedCache), len(cache), 'Cache count not match!')

    def testCacheManagerImport(self):
        with self.assertRaises(NotImplementedError):
            CacheManager().doImport([CacheImporter(name='MyCache1')])


if __name__ == '__main__':
    unittest.main()
