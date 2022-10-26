#!/bin/sh
# Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.

# configure with clang and any additional options, then run make clean all.

set -ex

export CC=clang
export CXX=clang++
export GYP_DEFINES="clang=1"

make clean
make dependencies
make native console=readline -j8

set +x
echo
echo 'build complete.'
