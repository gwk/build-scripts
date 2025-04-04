#!/bin/sh
# Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.

# Build sqlite with various extensions enabled.

set -ex

# SQLite transitioned to the "autosetup" build system in 3.49. This is an obscure, Tcl-based system that they bundle.
# Use `../configure --help` to see the available options.

configure_flags=(
  --all
  --with-readline-cflags=-I/opt/homebrew/opt/readline/include
  "--with-readline-ldflags=-L/opt/homebrew/opt/readline/lib -lreadline -lncurses"
)

cflags=(
  -DSQLITE_DEFAULT_MEMSTATUS=0 # Disable memory tracking interfaces to speed up sqlite3_malloc().
  -DSQLITE_DEFAULT_WAL_SYNCHRONOUS=1 # WAL mode defaults to PRAGMA synchronous=NORMAL instead of FULL. Faster and still safe.
  #-DSQLITE_DQS=0 # Disables double-quoted string literals, which breaks sloppy 3rd party tools.
  -DSQLITE_ENABLE_DBSTAT_VTAB
  -DSQLITE_ENABLE_EXPLAIN_COMMENTS
  -DSQLITE_ENABLE_NULL_TRIM
  -DSQLITE_ENABLE_PREUPDATE_HOOK
  -DSQLITE_LIKE_DOESNT_MATCH_BLOBS # LIKE and GLOB operators always return FALSE if either operand is a BLOB. Speeds up LIKE.
  -DSQLITE_OMIT_AUTOINIT # Helps many API calls run a little faster.
  -DSQLITE_OMIT_DEPRECATED
  #-DSQLITE_OMIT_SHARED_CACHE # Shared cache is a deprecated feature, but the Python sqlite3 links to it.
  -DSQLITE_STRICT_SUBTYPE=1
  -DSQLITE_THREADSAFE=1 # Default "serialized" mode. Safe for use in multithreaded environment.
)


export CFLAGS="${cflags[@]}"
export LDFLAGS="${ldflags[@]}"
../configure CC=clang CXX=clang++ "${configure_flags[@]}"

make clean
make

set +x
echo
printf '\nsqlite version: '
./sqlite3 -version
printf '\ncompile options: '
./sqlite3 ':memory:' 'PRAGMA compile_options;'
echo 'build complete; run `make install` as necessary.'
