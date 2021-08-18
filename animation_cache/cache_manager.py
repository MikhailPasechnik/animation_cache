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
"""Implements the cache manager class

Defines straight forward and simple logic for exporting and importing
cache with or without user interactions with hooks in important steps.
Core routines:
    - doExport: do export of a cache
    - doImport: do import of a cache
    - showGui: shows user interface based on operation
"""

import os
import json
import uuid
import datetime
import getpass
import logging
import traceback

import animation_cache
from animation_cache.cache import Cache

from pprint import pformat

logger = logging.getLogger(__name__)


class CacheException(Exception):
    """Base cache exception"""


class CacheManager(object):
    """Base class for cache pipeline.

    This class manages cache import and export, through consistent interface.
    """
    # key which used as unique id to perform merge in cache data
    _cacheIdKey = 'name'

    def __init__(self, factory=None):
        super(CacheManager, self).__init__()
        self._factory = None
        self.setFactory(factory)

    def setFactory(self, factory):
        self._factory = factory

    def getFactory(self):
        if not self._factory:
            raise CacheException('No factory given!')
        return self._factory

    def doExport(self, cache, directory, fstart, fend, samples=1, padding=4,
                 operation=animation_cache.kMergeCache, force=False, **kwargs):
        """
        :param directory: directory to write cache to
        :param cache: cache instances
        :param fstart: first frame
        :param fend: last frame
        :param samples: cache sampling
        :param padding: frame range padding
        :param operation: operation to perform when exporting cache
        :param force: if True passes write exceptions
        :return: writen cache data
        """
        if not cache:
            raise CacheException('No cache given to write!')
        if fstart > fend:
            raise CacheException('Frame end must be greater or equal to frame start')
        invalidCacheClass = [c for c in cache if not isinstance(c, Cache)]
        if invalidCacheClass:
            raise CacheException('Invalid cache classes: \n\t{}'.format(
                '\n\t'.join(map(repr, invalidCacheClass)))
            )
        self._preExport(cache)
        result = self._writeCache(cache, directory, fstart, fend,
                                  samples, padding, force, **kwargs)
        validResult = [r for r in result if result and not isinstance(r, Exception)]
        if not validResult:
            if not force:
                raise CacheException('No valid result after export: result: \n{}'.format(
                    pformat(result))
                )
            else:
                logger.warn('No valid result after export: result: \n{}'.format(pformat(result)))
        else:
            self._postExport(result)
        return validResult

    def doImport(self, cache, force=False, **kwargs):
        """Import given cache, if none given uses provided factory and data file to load it

        :param cache: cache instances
        :param force: if True passes import exceptions
        :return: result
        """
        if not cache:
            raise CacheException('No cache to import!')
        self._preImport(cache)
        result = self._importCache(cache, force, **kwargs)
        self._postImport(result)
        return result

    def getDefaultSettings(self):
        raise NotImplementedError

    def showGui(self, operationType, cache=None, parent=None):
        import animation_cache.cache_dialog
        return animation_cache.cache_dialog.showDialog(
            cacheManager=self,
            operationType=operationType,
            cache=cache,
            parent=parent
        )

    def _importCache(self, cache, force, **kwargs):
        result = []
        for c in cache:
            try:
                result.append(c.import_(**kwargs))
            except Exception as e:
                if force:
                    logger.warn('{}: Cache not imported {} due to exception: \n{}'.format(
                        self, c, traceback.format_exc()
                    ))
                    result.append(e)
                    pass
                else:
                    raise
        return result

    def _writeCache(self, cache, directory, fstart, fend, samples, padding, force, **kwargs):
        """Executes write methods of the caches"""
        result = []
        for c in cache:
            try:
                c.write(directory, fstart, fend, samples, padding, **kwargs)
                logger.debug('{}: Cache writen: {} \n{}'.format(
                    self, c, pformat(c)
                ))
                result.append(c)
            except Exception as e:
                if force:
                    logger.warn('{}: Cache not writen {} due to exception: \n{}'.format(
                        self, c, traceback.format_exc()
                    ))
                    result.append(e)
                    pass
                else:
                    raise
        return result

    # hooks
    def _preExport(self, cache):
        """"""

    def _postExport(self, result):
        """"""

    def _preImport(self, cache):
        """"""

    def _postImport(self, result):
        """"""
    # end hooks


class JsonCacheMixin(object):
    def _writeJson(self, name, data, operation):
        result = None
        if operation == animation_cache.kMergeCache and os.path.isfile(name):
            with open(name, 'r+') as existingDataFile:
                try:
                    existingData = json.load(existingDataFile)
                except ValueError as e:
                    logger.exception(e)
                    existingData = {}
                for d in data:
                    try:
                        existingData[d['name']] = d
                    except KeyError as e:
                        if e.args and e.args[0] == 'name':
                            raise CacheException('Required key "{}" missing in data'.format(
                                'name')
                            )
                        raise
                existingDataFile.seek(0)
                existingDataFile.truncate()
                self._preWriteData(existingData)
                json.dump(existingData, existingDataFile, indent=1, sort_keys=True)
            result = existingData

        elif operation == animation_cache.kOverwriteCache \
                or not os.path.isfile(name):
            if not os.path.isdir(os.path.dirname(name)):
                os.makedirs(os.path.dirname(name))
            with open(name, 'w') as newDataFile:
                newData = {}
                for d in data:
                    try:
                        newData[d['name']] = d
                    except KeyError as e:
                        if e.args and e.args[0] == 'name':
                            raise CacheException(
                                'Required key "{}" missing in data'.format('name'))
                        raise
                self._preWriteData(newData)
                json.dump(newData, newDataFile, indent=1, sort_keys=True)
            result = newData
        logger.debug('{}: _writeDataFile: paht: {} \nresult: \n{}'.format(
            self, name, pformat(result))
        )
        return result

    def _preWriteData(self, data):
        """"""
