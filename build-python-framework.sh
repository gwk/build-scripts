#!/bin/sh
# Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.

# build python (2.7 or 3.3) using clang.
# --enable-framework is required by some modules, particularly matplotlib.
# optional arguments:
# --with-pydebug

$(dirname $0)/build-with-clang.sh \
CFLAGS='-Wno-unused-value -Wno-empty-body -Wno-deprecated-declarations -Wno-tautological-compare -Qunused-arguments' \
--enable-framework=$(abs-path built-framework) \
--with-framework-name=Python-Embedded \
--prefix=$(abs-path prefix) \
"$@"
