#!/usr/bin/env bash
# Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.

set -euo pipefail

fail() { echo 'error:' "$@" 1>&2; exit 1; }

exe() { echo "$@"; "$@"; }


if [[ "$(basename $PWD)" =~ Python-.* ]]; then
  echo "Note: in Python source directory; cd'ing into _build directory."
  cd _build
fi

[[ "$(basename $PWD)" == _build ]] || error "Script must be run from _build directory."


VERSION=$(ls Python.framework/Versions | grep -E '3\.[0-9]+')
echo "VERSION: $VERSION"
[[ -n "$VERSION" ]] || fail 'could not detect python version.'

exe sudo mkdir -p /usr/local/py
exe sudo chown :admin /usr/local/py
exe sudo chmod g+rwx /usr/local/py

exe sudo rm -rf "/Applications/Python $VERSION"
#^ The Application is built and installed by the altinstall step which we do not give sudo privileges.
#^ Therefore we need to remove it first.

exe make altinstall
#^ This runs the ensurepip step at the end and would complain if it is run as root.
#^ Furthermore it compiles products into the build dir which are less easily removed if owned by root.

exe rm -rf /usr/local/py/bin # This directory is just symlinks; the bin/ inside of the version folder is what matters.

# Remove the symlinks that the installer just created in /usr/local/bin.
for bin in /usr/local/bin/{2to3,idle3,pip,pip3,pydoc,pydoc3,python,python3}; do
  exe sudo rm -f "$bin"
done

# The only executables that macOS provides in /usr/bin are python3 and pip3, so we need to override those.
# We additionally provide `python` and `pip` aliases in the same place for consistency.
# All others we rely on the user to provide a PATH entry to the framework bin dir.

# Note: we link `python` to the underlying mac binary that gets executed, so that lldb can debug it.
# This is an unusual trick and the ramifications are not fully understood.
# It appears that the normal `python` executable is a large binary that execs the underlying Python.app binary.
for name in python python3; do
  exe sudo ln -s /usr/local/py/Python.framework/Versions/$VERSION/Resources/Python.app/Contents/MacOS/Python /usr/local/bin/$name
done

for name in pip pip3; do
  exe sudo ln -s /usr/local/py/Python.framework/Versions/$VERSION/bin/pip$VERSION /usr/local/bin/$name
done

# Change permissions to allow pip installs without sudo.
# Make the entire python installation's owner group admin.
sudo chown -R :admin /usr/local/py/Python.framework/Versions/$VERSION

# Also take the opportunity to create some directories that certain packages want to write to.
for subdir in bin lib/python$VERSION/site-packages man share/doc; do
  d="/usr/local/py/Python.framework/Versions/$VERSION/$subdir"
  exe mkdir -p "$d"
  exe chmod -R g+rwx "$d"
done

exe python3 -m pip install --upgrade pip # Upgrade pip immediately; this will create the pip executables in $VERSION/bin.
#^ It will print a warning if permissions or path is incorrect.

py_bin=/usr/local/py/Python.framework/Versions/$VERSION/bin

echo
if echo "$PATH" | grep ":$py_bin:"; then
  echo "PATH contains '$py_bin'."
else
  echo "PATH does not contain '$py_bin'."
fi

set -x
python3 -c 'import dbm.gnu' # gdbm.
python3 -c 'import lzma' # xz.
python3 -c 'import readline; print("Readline backend:", readline.backend)'
python3 -c 'import ssl; print("SSL version:", ssl.OPENSSL_VERSION)'
python3 -c 'import sqlite3; print("SQLite version:", sqlite3.sqlite_version)'
python3 -c 'import tkinter; print("Tkinter version:", tkinter.TkVersion)'
