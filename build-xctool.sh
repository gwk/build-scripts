#!/bin/sh
# Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.

set -e

./scripts/make_release.sh
echo "using path specified above, e.g. '/var/.../xctool-release.../release', call:"
echo "cp -r PATH_TO_RELEASE /usr/local/xctool"
