#!/usr/bin/env bash
# Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.

fail() { echo 'error:' "$@" 1>&2; exit 1; }

exe() { echo "$@"; "$@"; }


VERSION=$(ls Python.framework/Versions | grep -E '3\.[0-9]+')
echo "VERSION: $VERSION"
[[ -n "$VERSION" ]] || fail 'could not detect python version.'

set -e
exe sudo mkdir -p /usr/local/py
exe sudo chown :admin /usr/local/py
exe sudo chmod g+w /usr/local/py

exe sudo make altinstall
#^ This runs the ensurepip step at the end, and will issue a warning about running pip as root.
#^ We fix this up with the permissions changes below.

exe sudo rm -rf /usr/local/py/bin # This directory is just symlinks; the bin/ inside of the version folder is what matters.

for bin in /usr/local/bin/{2to3,idle3,pip,pip3,pydoc,pydoc3,python,python3}; do
  exe sudo rm -f "$bin"
done

# The only executables that macOS provides in /usr/bin are python3 and pip3, so we need to override those.
# We additionally provide `python` and `pip` aliases in the same place for consistency.
# All others we rely on the user to provide a PATH entry to the framework bin dir.

# Note: we link `python` to the underlying mac binary that gets executed, so that lldb can debug it.
# This is an unusual trick and the ramifications are not fully understood.
# It appears that the normal `python` executable is a large binary that execs the underlying Python.app binary.
# I don't know why this is how macOS python is built by default.
for name in python python3; do
  exe sudo ln -s /usr/local/py/Python.framework/Versions/$VERSION/Resources/Python.app/Contents/MacOS/Python /usr/local/bin/$name
done

for name in pip pip3; do
  exe sudo ln -s /usr/local/py/Python.framework/Versions/$VERSION/bin/pip$VERSION /usr/local/bin/$name
done

# Prior to ownership changes, create a man dir. This is to accommodate pyperclip.
sudo mkdir -p /usr/local/py/Python.framework/Versions/$VERSION/man
#^ TODO: not sure if this is necessary.

# Change permissions to allowspip installs without sudo.
# Make the entire python installation's owner group admin.
exe sudo chown -R :admin /usr/local/py/Python.framework/Versions/$VERSION

# Give the admin sufficient write privileges.
# Also take the opportunity to create some directories that certain packages want to write to.
for subdir in bin lib/python$VERSION/site-packages man share/doc; do
  d="/usr/local/py/Python.framework/Versions/$VERSION/$subdir"
  exe sudo mkdir -p "$d"
  exe sudo chmod -R g+w "$d"
done

exe python3 -m pip install --upgrade pip # Upgrade pip immediately; this will create the pip executables in $VERSION/bin.
#^ It will print a warning if permissions or path is incorrect.

py_bin=/usr/local/py/Python.framework/Versions/$VERSION/bin

echo
if echo "$PATH" | grep ":$py_bin:"; then
  echo "PATH contains '$py_bin'."
else
  echo "PATH does not appear to contain '$py_bin'."
fi
