#!/bin/bash

set -o errexit

_mount_device() {
	sudo mount -v "${RAKLAP_BLOCKDEVICE}" "${RAKLAP_MOUNTPOINT}" -o "${RAKLAP_MOUNTOPTS}"
}

_umount_device() {
	sudo umount -v "${RAKLAP_BLOCKDEVICE}"
}

_format_device() {
	sudo mkfs.vfat -n RAKLAP -i "${1:-00000000}" -v -- "${RAKLAP_BLOCKDEVICE}"
}

_wipe_device() {
	mountpoint -- "${RAKLAP_MOUNTPOINT}" && find "${RAKLAP_MOUNTPOINT}" -type f -print0 | xargs --null -- shred --verbose --random-source=/dev/urandom -n1 --
}

_clean_device() {
	mountpoint -- "${RAKLAP_MOUNTPOINT}" || _mount_device
	_wipe_device
	_umount_device
	_format_device "${1:-00000000}"
	sync
}
