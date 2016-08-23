#!/usr/bin/env bash

#rmdir /p build
#mkdir build
#cd build

#set CFLAGS="-m32"

#cmake -DPLATFORM="Linux" -DCFLAGS=$CFLAGS ../
#make

#mv src/libslua.so ../../Assets/Plugins/x86/slua.so
#cd ..

rm -R build
mkdir build
cd build

set CFLAGS="-m64"

cmake -DPLATFORM="Linux" -DCFLAGS=$CFLAGS ../
make

mv src/libslua.so ../../Assets/Plugins/x64/slua.so
cd ..