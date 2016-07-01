#!/usr/bin/env bash

rm -R build
mkdir build
cd build

cmake -DPLATFORM="MacOSX" -G Xcode ../
xcodebuild -configuration Release

cp -r src/Release/libslua.dylib ../../Assets/Plugins/

cd ..