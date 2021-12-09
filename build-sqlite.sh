# Copyright 2011 George King. Permission to use this file is granted in license-gloss.txt.

# Build sqlite with various extensions enabled.


set -ex

../configure \
CC=clang CXX=clang++ \
--enable-session \
CFLAGS="\
-DSQLITE_DQS=0 \
-DSQLITE_DEFAULT_MEMSTATUS=0 \
-DSQLITE_DEFAULT_WAL_SYNCHRONOUS=1 \
-DSQLITE_ENABLE_EXPLAIN_COMMENTS \
-DSQLITE_ENABLE_GEOPOLY \
-DSQLITE_ENABLE_NULL_TRIM \
-DSQLITE_LIKE_DOESNT_MATCH_BLOBS \
-DSQLITE_OMIT_AUTOINIT \
-DSQLITE_OMIT_DEPRECATED \
-Os"

# Additional recommended options from http://www.sqlite.org/compile.html.
# These options together improve speed and footprint slightly.
#-DSQLITE_THREADSAFE=0 \
#-DSQLITE_MAX_EXPR_DEPTH=0 \
#-DSQLITE_OMIT_DECLTYPE \
#-DSQLITE_OMIT_PROGRESS_CALLBACK \
#-DSQLITE_OMIT_SHARED_CACHE

make clean
make -j6

set +x
echo
printf '\nsqlite version: '
./sqlite3 -version
echo 'build complete; run `make install` as necessary.'
