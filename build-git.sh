#!/bin/sh
# Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.

# build git using clang.

set -ex

# necessary when building from the git repo.
#autoreconf

# unlike many build scripts, we are obliged to run configure from the root dir;
# otherwise no Makefile appears in the build directory.
./configure \
--cache-file=config.cache \
CC=clang CXX=clang++ \
--prefix=/usr/local/git \
--with-openssl=/usr/local/ssl

make clean
make -j8

set +x
echo
echo 'build complete; run make install.'
