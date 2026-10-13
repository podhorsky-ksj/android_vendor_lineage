#!/bin/bash
set -eu

export ANDROID_BUILD_TOP="$PWD"

./bionic/libc/kernel/tools/clean_header.py -u \
    "$1/usr/include/asm/signal.h" \
    "$1/usr/include/asm-generic/signal.h"

# Bionic provides struct sched_param from sched.h. Older vendor kernels still
# export the duplicate definition from linux/sched/types.h.
if [ -f "$1/usr/include/linux/sched/types.h" ]; then
    sed -i '/^struct sched_param {$/,/^};$/d' \
        "$1/usr/include/linux/sched/types.h"
fi
