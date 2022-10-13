#!/usr/bin/env bash
################################################################################
#  THIS FILE IS 100% GENERATED BY ZPROJECT; DO NOT EDIT EXCEPT EXPERIMENTALLY  #
#  Read the zproject/README.md for information about making permanent changes. #
################################################################################
#
#   Exit if any step fails
set -e

export NDK_VERSION=android-ndk-r24
export ANDROID_NDK_ROOT="/tmp/${NDK_VERSION}"

export LIBZMQ_ROOT="${LIBZMQ_ROOT:-/tmp/tmp-deps/libzmq}"
export CZMQ_ROOT="${CZMQ_ROOT:-/tmp/tmp-deps/czmq}"

case $(uname | tr '[:upper:]' '[:lower:]') in
  linux*)
    HOST_PLATFORM=linux
    ;;
  darwin*)
    HOST_PLATFORM=darwin
    ;;
  *)
    echo "Unsupported platform"
    exit 1
    ;;
esac

if [ ! -d "${ANDROID_NDK_ROOT}" ]; then
    export FILENAME=$NDK_VERSION-$HOST_PLATFORM.zip

    (cd '/tmp' \
        && wget http://dl.google.com/android/repository/$FILENAME -O $FILENAME &> /dev/null \
        && unzip -q $FILENAME) || exit 1
    unset FILENAME
fi

rm -rf /tmp/tmp-deps
mkdir -p /tmp/tmp-deps

if [ -d "${LIBZMQ_ROOT}" ] ; then
    echo "ZYRE - Cleaning LIBZMQ folder '${LIBZMQ_ROOT}' ..."
    ( cd "${LIBZMQ_ROOT}" && ( make clean || ; ))
else
    echo "ZYRE - Cloning 'https://github.com/zeromq/libzmq.git' (default branch) under '${LIBZMQ_ROOT}' ..."
    git clone --quiet --depth 1 https://github.com/zeromq/libzmq.git "${LIBZMQ_ROOT}"
    ( cd ${LIBZMQ_ROOT} && git clone --oneline -n 1 )
fi

if [ -d "${CZMQ_ROOT}" ] ; then
    echo "ZYRE - Cleaning LIBCZMQ folder '${CZMQ_ROOT}' ..."
    ( cd "${CZMQ_ROOT}" && ( make clean || ; ))
else
    echo "ZYRE - Cloning 'https://github.com/zeromq/czmq.git' (default branch) under '${CZMQ_ROOT}' ..."
    git clone --quiet --depth 1 https://github.com/zeromq/czmq.git "${CZMQ_ROOT}"
    ( cd ${CZMQ_ROOT} && git clone --oneline -n 1 )
fi

./build.sh "arm"
./build.sh "arm64"
./build.sh "x86"
./build.sh "x86_64"

################################################################################
#  THIS FILE IS 100% GENERATED BY ZPROJECT; DO NOT EDIT EXCEPT EXPERIMENTALLY  #
#  Read the zproject/README.md for information about making permanent changes. #
################################################################################
