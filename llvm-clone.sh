#!/bin/sh
# Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.

set -ex

#git clone http://llvm.org/git/llvm.git llvm
git clone http://llvm.org/git/compiler-rt.git llvm/projects/compiler-rt
git clone http://llvm.org/git/clang.git llvm/tools/clang
git clone http://llvm.org/git/clang-tools-extra.git llvm/tools/clang/tools/extra
