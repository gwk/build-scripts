#!/bin/sh
# Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.

set -ex

git pull --rebase

cd tools/clang
git pull --rebase
cd -

cd projects/compiler-rt
git pull --rebase
cd -

cd tools/clang
git pull --rebase
cd -

cd tools/clang/tools/extra
git pull --rebase
cd -
