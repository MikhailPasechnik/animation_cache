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
"""Implements base class for animation cache and a factory

Cache class encapsulates export logic of an entity.

Cache Importer encapsulates import logic of an entity.

CacheFactory class encapsulates cache class instantiation logic and
used by cache manager in doExport and doImport routines if none cache provided
to get all cache from known location or from scene.
"""

import os
import uuid
import json
import logging
import datetime
import getpass

import animation_cache

logger = logging.getLogger(__name__)


class CacheFactory(object):
    """Base class for cache factory"""

    @classmethod
    def fromFile(cls, directory, dataFile=None):
        """Returns cache instances from data file"""
        cache = []
        if not dataFile:
            dataFile = os.path.join(directory, animation_cache.DATA_FILE_NAME)
        if os.path.isfile(dataFile):
            with open(dataFile, 'r') as f:
                data = json.load(f)
            cache = [
                cls.fromData(d, directory) for d in
                data.values()
            ]
        return [c for c in cache if c]

    @classmethod
    def fromData(cls, data, directory):
        return Cache(**data)

    @classmethod
    def fromEntity(cls, entity):
        if type(entity) == dict:
            return Cache(**entity)

    @classmethod
    def fromScene(cls):
        raise NotImplementedError


class Cache(dict):
    """Base class for cache"""
    type = None

    def write(self, directory, fstart, fend, samples=1, padding=4, **kwargs):
        """Writes actual cache"""
        # Provide basic information about this cache
        self.update({
            'id': str(uuid.uuid4()),
            'type': self.type,
            'datetime': datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S"),
            'fstart': fstart,
            'fend': fend,
            'samples': samples,
            'padding': padding,
            'user': getpass.getuser(),
            'files': [],
        })
        return self


class CacheImporter(dict):
    def __init__(self, importVariants=None, **data):
        super(CacheImporter, self).__init__(**data)
        self._importVariants = None
        self.importVariants = importVariants or []

    @property
    def type(self):
        return self.get('type')

    @property
    def importVariants(self):
        """Used in import process
        where first element treated as a main variant to import"""
        return self._importVariants

    @importVariants.setter
    def importVariants(self, value):
        self._importVariants = value

    def import_(self, **kwargs):
        raise NotImplementedError
