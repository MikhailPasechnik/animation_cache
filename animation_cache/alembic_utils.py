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
"""Alembic low level utils"""

import re
import collections
from alembic import Abc, AbcGeom, AbcMaterial, AbcCollection

_kWrapExisting = Abc.WrapExistingFlag.kWrapExisting


def getISubclassInstance(iObject):
    for n, t in [
        ("Xform", AbcGeom.IXform),
        ("PolyMesh", AbcGeom.IPolyMesh),
        ("Material", AbcMaterial.IMaterial),
        ("Camera", AbcGeom.ICamera),
        ("Light", AbcGeom.ILight),
        ("Points", AbcGeom.IPoints),
        ("FaceSet", AbcGeom.IFaceSet),
        ("Collections", AbcCollection.ICollections),
        ("Curve", AbcGeom.ICurves),
        ("NuPatch", AbcGeom.INuPatch),
        ("SubD", AbcGeom.ISubD),
    ]:
        if t.matches(iObject.getMetaData()):
            return t(iObject, _kWrapExisting)
    return iObject


def listArchive(
        archive,
        iType=None,
        hierarchyDepthLimit=None,
        regex=None,
        match=True,
        longName=False,
        ignoreNamespace=False):
    """Query object from alembic archive

    :type archive: Abc.IArchive
    :param iType: alembic.AbcGeom.IPolyMesh or similar
    :param hierarchyDepthLimit: limits hierarchy depth search
    :param regex: regular expression to match with
    :param match: used with regex and indicates filter out if match or not match
    :param longName: used with regex and indicates that match will be performed of long name
    :param ignoreNamespace: used with regex ignores namspaces while matching name
    :rtype: Iterator
    """
    top = archive.getTop()

    stack = zip([0] * len(top.children), top.children)
    while stack:
        hierarchyDepth, obj = stack.pop(0)

        # If iType check that object meta data matches with provided iType
        typeMatch = True if iType is None else iType.matches(obj.getMetaData())

        # Filter by object name or full name using regex
        if regex and typeMatch:
            if not longName:
                matchName = obj.getName()
                if ignoreNamespace:
                    matchName = matchName.split(':')[-1]
            else:
                matchName = obj.getFullName()
                if ignoreNamespace:
                    matchName = '/' + '/'.join([n.split(':')[-1] for n in matchName.split('/')])
            regexMatch = (not match and not re.match(regex, matchName))
        else:
            regexMatch = True

        # Summarise tests
        if typeMatch and regexMatch:
            yield getISubclassInstance(obj) if iType is None else iType(obj, _kWrapExisting)

        if hierarchyDepthLimit is None or hierarchyDepth + 1 > hierarchyDepthLimit:
            stack.extend(zip([hierarchyDepth + 1] * len(obj.children), obj.children))


def createAbcExportMelJob(*args, **kwargs):
    """Creates job for exporting using maya mel.eval.

    - Use it when multiple job support needed.
    - Use bool value for '-<flagName>' flags. True indicates that flag will be included.
    - Use keywords as flag=value or args as ('flag', value).
    - 'root' flag value can be PyMel node or string or OpenMaya dag path, single or list.
    - If order of flags is important or multiple flags with same name needed use args.

    :Example:

    >>> createAbcExportMelJob(
    >>>     ('fr', [20, 100]), ('fr', [0, 10]), ('step', 0.2),
    >>>     file='Job1.abc', root='|root_node',
    >>>     pythonPerFrameCallback="print  #FRAME#, #BOUNDSARRAY#"
    >>> )

    :returns: formatted mel AbcExport job as '-j "<args>"'
    """
    job = []
    surroundWithQuotes = [
        'file', 'f',
        'pythonPostJobCallback', 'ppc',
        'pythonPerFrameCallback', 'pfc',
        'melPostJobCallback', 'mpc',
        'melPerFrameCallback', 'mfc',
    ]
    for k, v in list(args) + kwargs.items():
        if k in ['root', 'rt']:
            if not isinstance(v, collections.Iterable):
                v = [v]
            for node in v:
                if hasattr(node, 'longName'):
                    dagPath = node.longName()
                elif hasattr(node, 'fullPathName'):
                    dagPath = node.fullPathName()
                else:
                    dagPath = node
                job.append('-root {}'.format(dagPath))
        elif k in surroundWithQuotes:
            job.append("-{} '{}'".format(k, v))
        elif type(v) == bool and v is True:
            # Regular AbcExport flag
            job.append('-{}'.format(k))
        elif type(v) == bool and v is False:
            # If flag value is False ignore it
            continue
        else:
            # AbcExport flag with value
            if type(v) in [list, tuple]:
                # For frameRange provided as list
                v = ' '.join(map(str, v))
            job.append('-{} {}'.format(k, v))

    return '-j "{}"'.format(' '.join(job))
