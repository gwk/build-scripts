# Copyright 2011 George King. Permission to use this file is granted in license-gloss.txt.

# build python using clang.
# --enable-framework is required by some modules, particularly matplotlib.
# optional arguments:
# --with-pydebug
# --enable-optimizations
# --with-lto

# if MACOSX_DEPLOYMENT_TARGET is not specified, then the setup.py readline hack fails and libedit does not get built.
# if 10.6 is specified, the newly built interpreter dies, at least for builds on 10.12.

set -e

error() { echo 'error:' "$@" 1>&2; exit 1; }

#version=$1; shift || error '$0: requires python version as first argument.'

prefix=$PWD/_prefix

echo "running configure..."
../configure \
--cache-file=config.cache \
CC=clang CXX=clang++ \
MACOSX_DEPLOYMENT_TARGET=10.9 \
CFLAGS='-Wno-unused-value -Wno-unused-function -Wno-unreachable-code -Wno-empty-body -Wno-deprecated-declarations -Wno-tautological-compare -Qunused-arguments' \
--cache-file=config.cache \
--prefix=$prefix \
--enable-framework=$prefix \
--quiet \
"$@"

echo "configure done."

make -j8

make install
