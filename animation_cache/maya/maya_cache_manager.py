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
"""Implements maya cache manager based on base implementation"""

import os
import logging
from functools import wraps

import pymel.core as pm
import maya.mel as mm

import animation_cache.alembic_utils as alembic_utils
import animation_cache as animation_cache
import animation_cache.utils
from animation_cache.cache_manager import CacheManager, JsonCacheMixin
from animation_cache.maya.maya_cache import AlembicCache, MayaCacheFactory

logger = logging.getLogger(__name__)


def viewportOff(func):
    """
    Decorator - turn off Maya display while func is running.
    if func will fail, the error will be raised after.
    """
    @wraps(func)
    def wrap(*args, **kwargs):
        # Turn $gMainPane Off:
        mm.eval("paneLayout -e -manage false $gMainPane")
        # Decorator will try/except running the function.
        # But it will always turn on the viewport at the end.
        # In case the function failed, it will prevent leaving maya viewport off.
        try:
            return func(*args, **kwargs)
        except Exception:
            raise  # will raise original error
        finally:
            mm.eval("paneLayout -e -manage true $gMainPane")
    return wrap


class MayaCacheManager(CacheManager, JsonCacheMixin):
    """"""
    _cacheSubFolder = 'maya_cache'

    def __init__(self, factory=MayaCacheFactory):
        super(MayaCacheManager, self).__init__(factory=factory)

    def getDefaultSettings(self):
        fstart, fend = self.getFrameRange()
        return dict(
            directory=self.getDefaultExportPath(),
            fstart=fstart,
            fend=fend,
            samples=1.0,
            padding=4
        )

    @staticmethod
    def getDefaultExportPath():
        directory = os.path.join(
            os.path.abspath(os.path.normpath(os.path.dirname(pm.system.sceneName()))),
            MayaCacheManager._cacheSubFolder)
        return directory

    @staticmethod
    def getFrameRange():
        return int(pm.playbackOptions(q=True, minTime=True)), \
               int(pm.playbackOptions(q=True, maxTime=True))

    @viewportOff
    def doExport(self, cache=None, directory=None, fstart=None, fend=None,
                 samples=1, padding=4, operation=animation_cache.kMergeCache,
                 force=False, batchAbcExport=True, dataFileName=None, **kwargs):

        # Defaults
        if cache is None:
            cache = self.getFactory().fromScene()
        defaultFRange = self.getFrameRange() if fstart is None or fend is None else None
        directory = directory or self.getDefaultExportPath()
        fstart = fstart if fstart is not None else defaultFRange[0]
        fend = fend if fend is not None else defaultFRange[1]
        result = super(MayaCacheManager, self).doExport(
            cache, directory, fstart, fend, samples, padding, operation, force,
            batchAbcExport=True, **kwargs
        )
        self._writeJson(
            os.path.join(directory, dataFileName or animation_cache.DATA_FILE_NAME),
            result, operation
        )
        return result

    def _writeCache(self, cache, directory, fstart, fend, samples, padding, force, **kwargs):
        """Writes cache and exports all alembic cache in one take"""
        result = super(MayaCacheManager, self)._writeCache(
            cache, directory, fstart, fend, samples, padding, force, **kwargs)
        directory = directory or self.getDefaultExportPath()
        if kwargs.get('batchAbcExport'):
            # Export alembic cache
            alembicJobs = []
            for c in cache:
                if not isinstance(c, AlembicCache):
                    continue
                alembicJobs.append(
                    alembic_utils.createAbcExportMelJob(
                        *c.alembicJobArgs, **c.alembicJobKwargs
                    )
                )
            if alembicJobs:
                self._preAlembicExport(cache, directory)
                logger.debug('Batch abc export: jobs:\n\t{}'.format('\n\t'.join(alembicJobs)))
                pm.mel.eval('AbcExport {}'.format(' '.join(alembicJobs)))
                self._postAlembicExport(cache, directory)

        return result

    def _preAlembicExport(self, cache, directory):
        """"""
        if not pm.pluginInfo('AbcExport', loaded=1, q=1):
            pm.loadPlugin('AbcExport')

        for c in cache:
            if not isinstance(c, AlembicCache):
                continue
            alembicFile = os.path.join(directory, c.alembicFileName)
            c['files'].append(alembicFile)
            alembicDirectory = os.path.dirname(alembicFile)
            if not os.path.isdir(alembicDirectory):
                animation_cache.utils.makeDirs(alembicDirectory)

    def _postAlembicExport(self, cache, directory):
        """TODO: validate exported cache"""

    def showGui(self, operationType, cache=None, parent=None):
        # Parent dialog to maya main window
        if parent is None:
            import maya.OpenMayaUI
            try:
                import shiboken2
            except ImportError:
                import shiboken as shiboken2
            from animation_cache.vendor.Qt import QtWidgets
            parent = shiboken2.wrapInstance(
                int(maya.OpenMayaUI.MQtUtil.mainWindow()),
                QtWidgets.QMainWindow) if maya.OpenMayaUI.MQtUtil.mainWindow() else None
        return super(MayaCacheManager, self).showGui(
            operationType=operationType,
            cache=cache,
            parent=parent
        )
