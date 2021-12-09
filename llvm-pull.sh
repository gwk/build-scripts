set -ex

git pull --rebase

cd tools/clang
git pull --rebase
cd -

cd projects/compiler-rt
git pull --rebase
cd -

cd tools/clang
git pull --rebase
cd -

cd tools/clang/tools/extra
git pull --rebase
cd -
