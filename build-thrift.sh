#!/bin/sh
# Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.

set -ex

# unlike many build scripts, we are obliged to run configure from the root dir;
# otherwise, recursive make in lib/py fails.

./configure \
CC=clang CXX=clang++

make clean
make -j8

set +x
echo
echo 'build complete; run make install.'
