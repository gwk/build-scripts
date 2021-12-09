#!/bin/sh
# Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.

set -ex

./configure
make world.opt
sudo make install
