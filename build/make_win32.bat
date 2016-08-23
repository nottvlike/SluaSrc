rmdir /S /Q build
mkdir build
cd build

set CFLAGS="-m32"

cmake -DPLATFORM="Win32" -DCFLAGS=%CFLAGS% -G "MinGW Makefiles" ../
mingw32-make 

copy /Y src\\libslua.dll ..\\..\\Assets\\Plugins\\x86\\slua.dll

cd ..
::rmdir /S /Q build
::mkdir build
::cd build

::set CFLAGS="-m64"

::cmake -DPLATFORM="Win32" -DCFLAGS=%CFLAGS% -G "MinGW Makefiles" ../
::mingw32-make

::copy /Y src\\libslua.dll ..\\..\\Assets\\Plugins\\x64\\slua.dll

::cd ..