#!/usr/bin/env bash

rm -R build
mkdir build
cd build

ANDROID_TOOLCHAIN_CMAKE="../cmake/modules/android-cmake/android.toolchain.cmake"
NDK_PATH="/cygdrive/d/android-ndk-r10e"
BUILD_TYPE="Debug"
API_LEVEL=21
ABI_TYPE="armeabi-v7a"
CFLAGS=

set CFLAGS=

cmake -DCMAKE_TOOLCHAIN_FILE=$ANDROID_TOOLCHAIN_CMAKE -DCFLAGS=$CFLAGS -DANDROID_NDK=$NDK_PATH -DCMAKE_BUILD_TYPE=$BUILD_TYPE -DANDROID_NATIVE_API_LEVEL=$API_LEVEL -DANDROID_ABI=$ABI_TYPE -DPLATFORM="Android" -G "MinGW Makefiles" ../
cmake --build .
#mv src/libslua.so ../../Assets/Plugins/x86/slua.so
#cd ..

#rm -R build
#mkdir build
#cd build

#set CFLAGS="-m64"

#cmake -DCMAKE_TOOLCHAIN_FILE=$ANDROID_TOOLCHAIN_CMAKE -DCFLAGS=$CFLAGS -DANDROID_NDK=$NDK_PATH -DCMAKE_BUILD_TYPE=$BUILD_TYPE -DANDROID_NATIVE_API_LEVEL=$API_LEVEL -DANDROID_ABI=$ABI_TYPE -DPLATFORM="Android" -G "MinGW Makefiles" ../
#cmake --build .

#mv src/libslua.so ../../Assets/Plugins/x64/slua.so
#cd ..