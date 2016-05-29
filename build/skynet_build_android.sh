# set params
NDK_ROOT_LOCAL="/Users/nottvlike/Documents/program/android-ndk-r9d"
SKYNET_ROOT="/Users/nottvlike/Documents/github/slua/build/skynet/skynet"

cp slua.c skynet/jni/

cd skynet

$NDK_ROOT_LOCAL/ndk-build "NDK_MODULE_PATH=${SKYNET_ROOT}" NDK_DEBUG=1

cp -f -R libs ../../Assets/Plugins/Android
cd ../