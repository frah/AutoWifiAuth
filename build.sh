#!/bin/sh

rm -f *.deb
make clean package
PKG_NAME=`find . -name "*.deb"`
cp -r Library .theos/_/
find .theos/_/ -name ".*" -type f | xargs rm
dpkg-deb -b .theos/_ $PKG_NAME

