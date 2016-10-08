#!/bin/bash
SDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

. $SDIR/.raklaprc
. $SDIR/.raklaputils.sh

_mount_device

DSTPATH="${RAKLAP_INCOMINGDIR}/$(date +'raklap_%Y-%m-%d_%H-%M-%S')"
mkdir -pv -- "${DSTPATH}"

pushd "${RAKLAP_MOUNTPOINT}" && tar cf - -- . | tar xvf - -C "${DSTPATH}"
popd

find "${DSTPATH}" -ls
echo "Dest dir is ${DSTPATH}"

_umount_device
