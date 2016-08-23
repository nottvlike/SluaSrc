rmdir /S /Q build
mkdir build
cd build

::android.toolchain.cmake文件路径
set ANDROID_TOOLCHAIN_CMAKE="..\\cmake\\modules\\android-cmake\\android.toolchain.cmake"
::NDK path
set NDK_PATH="D:\\android-ndk-r10e"
::输出类型 Release or Debug
set BUILD_TYPE="Release"
::android api level
set API_LEVEL=9
::架构类型 x86 or armeabi-v7a
set ABI_TYPE="armeabi-v7a"
set CFLAGS=

cmake -DCMAKE_TOOLCHAIN_FILE=%ANDROID_TOOLCHAIN_CMAKE% -DCFLAGS=%CFLAGS% -DANDROID_NDK=%NDK_PATH% -DCMAKE_BUILD_TYPE=%BUILD_TYPE% -DANDROID_NATIVE_API_LEVEL=%API_LEVEL% -DANDROID_ABI=%ABI_TYPE% -DPLATFORM="Android" -G "MinGW Makefiles" ../
cmake --build .

copy /Y src\\libslua.so ..\\..\\Assets\\Plugins\\Android\\libs\\armeabi-v7a\\libslua.so

cd ..
rmdir /S /Q build
mkdir build
cd build

set ABI_TYPE="x86"

cmake -DCMAKE_TOOLCHAIN_FILE=%ANDROID_TOOLCHAIN_CMAKE% -DCFLAGS=%CFLAGS% -DANDROID_NDK=%NDK_PATH% -DCMAKE_BUILD_TYPE=%BUILD_TYPE% -DANDROID_NATIVE_API_LEVEL=%API_LEVEL% -DANDROID_ABI=%ABI_TYPE% -DPLATFORM="Android" -G "MinGW Makefiles" ../
cmake --build .

copy /Y src\\libslua.so ..\\..\\Assets\\Plugins\\Android\\libs\\x86\\libslua.so

cd ..