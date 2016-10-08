#!/bin/bash
set -o errexit
SDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. "${SDIR}/.raklaprc"
. "${SDIR}/.raklaputils.sh"


_usage() {
	echo "Usage: $0 [-t tar filename] FILES ..."
	exit 0
}
if (( $# != 0 )); then
	while getopts ht: opt
	do
		case "$opt" in
		(h)
			_usage;;
		(t) export TARNAME="${OPTARG}";;
		esac
	done
	shift $(( $OPTIND - 1 ))
else
	_usage
fi

_clean_device "$(date +%Y%m%d)"
_mount_device

[[ -z ${TARNAME} ]] && {
	tar cf - -- "$@" | tar xvf - -C "${RAKLAP_MOUNTPOINT}"
} || {
	tar cvf "${RAKLAP_MOUNTPOINT}/${TARNAME}.tar.gz" -- "$@"
}

echo "### Drive contents now:"

find "${RAKLAP_MOUNTPOINT}" -ls

_umount_device

sync

