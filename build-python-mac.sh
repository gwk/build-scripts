#!/bin/sh
# Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.

# Build python with modern openssl, readline, sqlite, and other dependencies.

# Complete steps to build on mac successfully:
# * build-sqlite.sh with latest sqlite3.
# * brew install openssl.
# * brew install ca-certificates, ncurses, pkg-config, readline, xz.
# * Run this script.
# * Run install-python-mac.sh.

# optional arguments:
# --with-pydebug
# --disable-optimizations

set -e

error() { echo 'error:' "$@" 1>&2; exit 1; }

[[ "$(basename $PWD)" == "_build" ]] || error "must be run from _build directory"

prefix=/usr/local/py

# If MACOSX_DEPLOYMENT_TARGET is not specified, then the setup.py readline hack fails and libedit does not get built.
# We no longer rely on libedit because it fails display the 0xff UTF8 character properly.
export MACOSX_DEPLOYMENT_TARGET=15.1

cc_no_warning_flags='-Wno-unreachable-code -Wno-deprecated-declarations' # These drift over time.

export CFLAGS="$cc_no_warning_flags -I/usr/local/include"
export LDFLAGS='-L/usr/local/lib'

# pkg-config paths provided by homebrew via pkgconfig.
# Note that we could specify openssl here but instead use the --with-openssl argument to configure.
pre=/opt/homebrew/opt
suf=lib/pkgconfig
brew_pc_deps=(
  $pre/readline/$suf
  $pre/xz/$suf
)
_pc_spaced="${brew_pc_deps[@]}"
export PKG_CONFIG_PATH="${_pc_spaced/ /:}"


echo "MACOSX_DEPLOYMENT_TARGET: $MACOSX_DEPLOYMENT_TARGET"
echo "CFLAGS: $CFLAGS"
echo "LDFLAGS: $LDFLAGS"
echo "PKG_CONFIG_PATH: $PKG_CONFIG_PATH"

echo "running configure..."
../configure \
--cache-file=config.cache \
CC=clang CXX=clang++ \
--prefix=$prefix \
--enable-framework=$prefix \
--enable-optimizations \
--enable-loadable-sqlite-extensions \
-with-openssl=$(brew --prefix openssl@3) \
"$@"

echo "configure done."

make -j8
echo
echo "make done."
echo 'run build-scripts/install-python-mac.sh to install.'
