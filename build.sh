#!/bin/bash

set -eo pipefail

LINARO_AARCH64_TOOLCHAIN_HOME=/home/nebula/devel/grpower/workspace/nebula/prebuilts/gcc-linaro-7.5.0-2019.12
GCC_TOOLCHAIN_PREFIX="${LINARO_AARCH64_TOOLCHAIN_HOME}/bin"
GCC_TOOLCHAIN_SYSROOT="${LINARO_AARCH64_TOOLCHAIN_HOME}/aarch64-linux-gnu/libc"

dstdir=$PWD/build
srcdir=$PWD
logfile=${dstdir}/build-socat.log

export CC=${GCC_TOOLCHAIN_PREFIX}/aarch64-linux-gnu-gcc
export CFLAGS="-I${srcdir}"
export LD=${CLANG_TOOLCHAIN_PREFIX}/aarch64-linux-gnu-ld

rm -rf ${dstdir}
mkdir -p "${dstdir}"
pushd "${dstdir}" > /dev/null

${srcdir}/configure --prefix="${dstdir}" --host=aarch64-linux-gnu | tee ${logfile}

ln -s ${srcdir}/procan.c procan.c

make -j "$(getconf _NPROCESSORS_ONLN)" | tee -a ${logfile}

popd > /dev/null

