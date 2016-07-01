rmdir /S /Q build
mkdir build
cd build

cmake -DPLATFORM="Win32" -DUSE_32BITS=1 -G "MinGW Makefiles" ../
mingw32-make

copy /Y src\\libslua.dll ..\\..\\Assets\\Plugins\\x86\\slua.dll

cd ..
rmdir /S /Q build
mkdir build
cd build
cmake -DPLATFORM="Win32" -G "MinGW Makefiles" ../
mingw32-make

copy /Y src\\libslua.dll ..\\..\\Assets\\Plugins\\x64\\slua.dll

cd ..