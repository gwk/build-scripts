#!/bin/sh
# Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.

$(dirname $0)/build-with-clang.sh \
--prefix=/usr/local/turbojpeg \
--enable-static \
--disable-shared \
'--with-jpeg8' \
