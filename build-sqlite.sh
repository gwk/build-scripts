#!/bin/sh
# Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.

# Build sqlite with various extensions enabled.

set -ex

# Tried to get ICU extension working with this but linking fails.
#-DSQLITE_ENABLE_ICU
#CFLAGS:  -I/opt/homebrew/opt/icu4c/include
#LDFLAGS: -L/opt/homebrew/opt/icu4c/lib

cflags=(
  -DSQLITE_DEFAULT_MEMSTATUS=0 # Disable memory tracking interfaces to speed up sqlite3_malloc().
  -DSQLITE_DEFAULT_WAL_SYNCHRONOUS=1 # WAL mode defaults to PRAGMA synchronous=NORMAL instead of FULL. Faster and still safe.
  #-DSQLITE_DQS=0: # Disables double-quoted string literals, which breaks sloppy 3rd party tools.
  -DSQLITE_ENABLE_DBSTAT_VTAB
  -DSQLITE_ENABLE_EXPLAIN_COMMENTS
  -DSQLITE_ENABLE_FTS5
  -DSQLITE_ENABLE_GEOPOLY
  -DSQLITE_ENABLE_NULL_TRIM
  -DSQLITE_ENABLE_PREUPDATE_HOOK
  -DSQLITE_ENABLE_RBU
  -DSQLITE_ENABLE_RTREE
  -DSQLITE_ENABLE_SESSION
  -DSQLITE_LIKE_DOESNT_MATCH_BLOBS # LIKE and GLOB operators always return FALSE if either operand is a BLOB. Speeds up LIKE.
  -DSQLITE_OMIT_AUTOINIT # Helps many API calls run a little faster.
  -DSQLITE_OMIT_DEPRECATED
  #-DSQLITE_OMIT_SHARED_CACHE # Shared cache is a deprecated feature, but the Python sqlite3 links to it.
  -DSQLITE_THREADSAFE=1 # Default "serialized" mode. Safe for use in multithreaded environment.
  -I/opt/homebrew/opt/readline/include
  -Os
)

ldflags=(
  -L/opt/homebrew/opt/readline/lib
)

export CFLAGS="${cflags[@]}"
export LDFLAGS="${ldflags[@]}"
../configure CC=clang CXX=clang++

make clean
make -j8

set +x
echo
printf '\nsqlite version: '
./sqlite3 -version
printf '\ncompile options: '
./sqlite3 ':memory:' 'PRAGMA compile_options;' | grep ENABLE
echo 'build complete; run `make install` as necessary.'
