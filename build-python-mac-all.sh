# Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.

set -e

error() { echo 'error:' "$@" 1>&2; exit 1; }

[[ -r configure ]] || error "this script must be run from cpython project root."

mkdir -p _build

for version in 3.{8,9,10}; do
  echo
  echo "VERSION: $version"
  git checkout $version
  git pull
  mkdir -p _build-$version
  rm -rf _build-$version/*
  cd _build-$version
  $(dirname $0)/build-python-mac.sh $version
  cd -
done

Versions=$prefix/Python.framework/Versions

for v in $Versions/*.*; do last=$v; done

echo "note: $Versions/Current"
ls -l $last $Versions/Current
