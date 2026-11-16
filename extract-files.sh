#!/bin/bash
#
# Copyright (C) 2016 The CyanogenMod Project
# Copyright (C) 2017-2020 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

set -e

VENDOR=samsung
DEVICE=zeroflte

# Load extract_utils and do some sanity checks
MY_DIR="${BASH_SOURCE%/*}"
if [[ ! -d "${MY_DIR}" ]]; then MY_DIR="${PWD}"; fi

ANDROID_ROOT="${MY_DIR}/../../.."

HELPER="${ANDROID_ROOT}/tools/extract-utils/extract_utils.sh"
if [ ! -f "${HELPER}" ]; then
    echo "Unable to find helper script at ${HELPER}"
    exit 1
fi
source "${HELPER}"

# Default to sanitizing the vendor folder before extraction
CLEAN_VENDOR=true

KANG=
SECTION=

while [ "${#}" -gt 0 ]; do
    case "${1}" in
        -n | --no-cleanup )
                CLEAN_VENDOR=false
                ;;
        -k | --kang )
                KANG="--kang"
                ;;
        -s | --section )
                SECTION="${2}"; shift
                CLEAN_VENDOR=false
                ;;
        * )
                SRC="${1}"
                ;;
    esac
    shift
done

if [ -z "${SRC}" ]; then
    SRC="adb"
fi


# Initialize the helper
setup_vendor "${DEVICE}" "${VENDOR}" "${ANDROID_ROOT}" false "${CLEAN_VENDOR}"

extract "${MY_DIR}/proprietary-files.txt" "${SRC}" "${KANG}" --section "${SECTION}"

# Fix proprietary blobs
BLOB_ROOT="$ANDROID_ROOT"/vendor/"$VENDOR"/"$DEVICE"/proprietary

# Android 17 has no VNDK, so vendor code can't load libstdc++. These blobs
# only list it; their __cxa_* symbols come from libc.
for lib in lib lib64; do
    for blob in libbauthtzcommon.so libegis_fp_normal_sensor_test.so libgf_in_system_lib.so; do
        [ -f "$BLOB_ROOT/vendor/$lib/$blob" ] && "${PATCHELF}" --remove-needed libstdc++.so "$BLOB_ROOT/vendor/$lib/$blob"
    done
done
"${PATCHELF}" --remove-needed libstdc++.so $BLOB_ROOT/vendor/lib/soundfx/libLifevibes_lvverx.so
"${PATCHELF}" --remove-needed libstdc++.so $BLOB_ROOT/vendor/lib/soundfx/libLifevibes_lvvetx.so

"${MY_DIR}/setup-makefiles.sh"
