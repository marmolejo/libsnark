#!/bin/sh
# This script fetches, builds and locally installs the external ate-pairing library (and its dependency, xbyak)

set -x -e

DEBUG=off
if [ $# -ge 1 ]; then
  if [ $1 = "debug" ]; then
    echo "Setting debug flags"
    DEBUG=on
  fi
fi

DEPSRC=./depsrc
DEPINST=./depinst

# rm -fr $DEPINST
mkdir -p $DEPINST
mkdir -p $DEPSRC

cd $DEPSRC
[ ! -d xbyak ] && git clone https://github.com/herumi/xbyak.git
[ ! -d ate-pairing ] && git clone https://github.com/marmolejo/ate-pairing.git
cd ate-pairing
make -j SUPPORT_SNARK=1 DBG=$DEBUG
cd ..
cd ..
cp -rv $DEPSRC/ate-pairing/include $DEPINST/
cp -rv $DEPSRC/ate-pairing/lib $DEPINST/
