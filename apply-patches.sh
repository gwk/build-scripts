#!/bin/sh
# Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.

# apply patches (developed for gnu readline and bash).

set -e

error() { echo 'error:' "$@" 1>&2; exit 1; }

src_dir=$(pwd)
parent_dir=$(dirname "$src_dir")
name=$(basename "$src_dir")
patch_dir="$parent_dir/${name}-patches"
patch_applied_dir="${patch_dir}-applied"

[[ -d "$patch_dir" ]] || error "no patch dir found: $patch_dir"

echo "applying patches in: $patch_dir"
echo "note: do not apply patches multiple times. applied patches will be moved to: $patch_applied_dir"
echo

mkdir -p "$patch_applied_dir"

for p in "$patch_dir/"*; do
  echo "applying patch: $p"
  # apply patch across same level of directory nesting
  patch -p0 <"$p" || error 'patch failed'
  p_applied="$patch_applied_dir/$(basename "$p")"
  mv "$p" "$p_applied" || error "move applied patch: $p -> $p_applied"
  echo
done

echo "all patches applied."
