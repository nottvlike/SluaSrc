
set(APP_SRC slua.c)

if(${PLATFORM} STREQUAL "Android")
	set(APP_SRC slua.c FileHelperAndroid.cpp)
	set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -landroid -lm")
	set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -landroid -lm")
elseif(${PLATFORM} STREQUAL "Win32")
	set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -DLUA_BUILD_AS_DLL")
	set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -DLUA_BUILD_AS_DLL")
endif()

add_library(${PROJECT_NAME} SHARED ${APP_SRC})
target_link_libraries(${PROJECT_NAME} "-Wl,-whole-archive" lua "-Wl,--no-whole-archive" luac lpeg)