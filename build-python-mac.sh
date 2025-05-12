#!/bin/sh
# Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.

# Build python with modern openssl, readline, sqlite, and other dependencies.

# Complete steps to build on mac successfully:
# * build-sqlite.sh with latest sqlite3.
# * `brew install openssl ca-certificates ncurses pkg-config readline xz`
# * `brew upgrade`
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

brew_path() {
  local pgk_name="$1"
  shift
  brew_prefix="$(brew --prefix "$pgk_name")"
  [[ $? -eq 0 ]] || error "brew --prefix $pgk_name failed."
  echo "$brew_prefix"/"$@"
}

CFLAGS=''
LDFLAGS=''

CFLAGS+=' -Wstrict-prototypes -Wno-deprecated-declarations -Wno-unreachable-code' # Warning flags. These drift over time.

CFLAGS+=' -I/usr/local/include' # For locally built sqlite.
LDFLAGS+=' -L/usr/local/lib' # For locally built sqlite.

CFLAGS+=" -I$(brew_path 'gdbm' 'include')"
LDFLAGS+=" -L$(brew_path 'gdbm' 'lib')"

CFLAGS+=" -I$(brew_path 'tcl-tk' 'include/tcl-tk')" # For tkinter.
LDFLAGS+=" -L$(brew_path 'tcl-tk' 'lib')" # For tkinter.

# pkg-config paths provided by homebrew via pkgconfig.
# Note that we could specify openssl here but instead use the --with-openssl argument to configure.
PKG_CONFIG_PATH="\
$(brew_path readline 'lib/pkgconfig'):\
$(brew_path xz 'lib/pkgconfig')"

export CFLAGS
export LDFLAGS
export PKG_CONFIG_PATH

echo "MACOSX_DEPLOYMENT_TARGET: $MACOSX_DEPLOYMENT_TARGET"
echo "CFLAGS: $CFLAGS"
echo "LDFLAGS: $LDFLAGS"
echo "PKG_CONFIG_PATH: $PKG_CONFIG_PATH"

echo "running configure..."
../configure \
 CC=clang CXX=clang++ \
 --cache-file=config.cache \
 --prefix=$prefix \
 --enable-framework=$prefix \
 --enable-loadable-sqlite-extensions \
 --with-openssl=$(brew --prefix openssl@3) \
 --enable-optimizations \
 --with-computed-gotos \
 "$@"

# Note: we explicitly specify with-computed-gotos so that if the compiler does not support them, the build will fail.
# Doing so also makes it more obvious from sysconfig results that computed gotos are enabled.

echo "configure done."

make -j$(sysctl -n hw.logicalcpu)
echo
echo "make done."
echo 'run build-scripts/install-python-mac.sh to install.'
