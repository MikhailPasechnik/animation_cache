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
"""Low level utils"""

import os
import sys
import logging
import traceback

logger = logging.getLogger(__name__)


def makeDirs(directory):
    """Custom make dirs method with error handling"""
    if not os.path.isdir(directory):
        try:
            os.makedirs(directory)
        except OSError as e:
            if os.name == 'nt' and e.args and e.args[0] == 183:
                logger.debug(
                    'Trying to create folder that is already exist'
                    ' after os.path.isdir check, exception: \n{}'.format(
                        traceback.format_exc())
                )
            else:
                raise
