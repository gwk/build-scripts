#!/usr/bin/env bash
# Copyright 2012 George King. Permission to use this file is granted in license-gloss.txt.

set -e


fetch_src() {
  local main_name=$1
  local main_url=$2
  echo $main_url
  curl --progress-bar -O "$main_url"
  tar -xzf "$main_name.tar.gz" "$main_name"
}


fetch_patches() {
  local main_name=$1
  local patch_url_prefix=$2
  local last_patch_index=$3
  patch_dir="${main_name}-patches"
  mkdir -p "$patch_dir"
  cd "$patch_dir"
  for i in $(seq -f '%03g' 1 "$last_patch_index"); do
    curl --progress-bar -O "$patch_url_prefix-$i"
  done
  cd -
}


fetch_src readline-6.3 http://ftp.gnu.org/gnu/readline/readline-6.3.tar.gz
fetch_patches readline-6.3 http://ftp.gnu.org/gnu/readline/readline-6.3-patches/readline63 6
