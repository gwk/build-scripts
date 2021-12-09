#!/bin/sh
# Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.

set -ex

# we are obliged to run configure from the root dir; otherwise, make install fails.
./configure \
CC=clang CXX=clang++ \
--prefix=/usr/local/gnu

make clean
make -j8

set +x
echo
echo 'build complete; run make install.'

