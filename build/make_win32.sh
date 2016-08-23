#!/usr/bin/env bash

rm -R build
mkdir build
cd build

set CFLAGS="-m32"

cmake -DPLATFORM="Win32" -DCFLAGS=$CFLAGS ../
make

mv src/msys-slua.dll ../../Assets/Plugins/x86/slua.dll
cd ..

#rm -R build
#mkdir build
#cd build

#set CFLAGS="-m64"

#cmake -DPLATFORM="Win32" -DCFLAGS=$CFLAGS ../
#make

#mv src/msys-slua.dll ../../Assets/Plugins/x64/slua.dll
#cd ..