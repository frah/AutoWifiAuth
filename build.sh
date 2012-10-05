#!/bin/sh

rm -f *.deb
make clean package
PKG_NAME=`find . -name "*.deb"`
cp -r Library .theos/_/
dpkg-deb -b .theos/_ $PKG_NAME

