#!/bin/sh
# Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.

set -ex

make WITHOUT_GETTEXT=1
sudo make install WITHOUT_GETTEXT=1
