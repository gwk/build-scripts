# Copyright 2011 George King. Permission to use this file is granted in license-gloss.txt.

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
