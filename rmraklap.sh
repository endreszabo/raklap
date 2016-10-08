#!/bin/bash
set -o errexit

SDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

. "${SDIR}/.raklaprc"
. "${SDIR}/.raklaputils.sh"

_clean_device
