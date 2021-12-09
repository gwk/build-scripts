#!/bin/sh
# Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.

set -ex

LDFLAGS="-framework CoreFoundation -framework Carbon" \
../configure --with-internal-glib

make
