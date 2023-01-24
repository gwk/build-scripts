#!/bin/sh
# Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.

pkgs=(
  blake3
  boto3
  commonmark
  gunicorn
  hatch
  html5-parser
  isort
  itsdangerous
  jmespath
  jurigged
  keyring
  lxml
  MarkupSafe
  #mypy
  #mypy-extensions
  nose
  numpy
  ovld
  packaging
  pandas
  pandas-stubs
  Pillow
  pip
  Pygments
  python-dateutil
  pytz
  PyYAML
  s3transfer
  starlette
  tomli_w
  tomlkit
  types-docutils
  types-lxml
  types-Pillow
  types-Pygments
  types-pytz
  types-PyYAML
  typing_extensions
  uvicorn
  watchfiles
  websockets
  zstandard
)

for pkg in "${pkgs[@]}"; do
  echo
  pip install --upgrade "$pkg"
done
