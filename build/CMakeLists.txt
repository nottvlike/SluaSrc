#
#PLATFORM : 自定义变量，表示平台，有Androiod, Win32, iOS, MacOSX
#
project(slua)
# version我随意写的，若是你的版本小于这个版本，可以改成自己的版本试试
cmake_minimum_required(VERSION 2.8)

include_directories(${PROJECT_SOURCE_DIR}/skynet/3rd/lua)
include_directories(${PROJECT_SOURCE_DIR}/skynet/skynet-src)


set(PROJECT_NAME "slua")
if(USE_32BITS)
	if(${PLATFORM} STREQUAL "Win32")
		message(STATUS "using 32bits")  
		set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -m32")    
		set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -m32")
	elseif(${PLATFORM} STREQUAL "MacOSX")
		set(CMAKE_OSX_ARCHITECTURES i386)
	endif()
endif()


add_subdirectory(skynet/3rd/lua)
add_subdirectory(skynet/3rd/lpeg)
add_subdirectory(skynet/lualib-src/)
add_subdirectory(src)