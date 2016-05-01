# set params
NDK_ROOT_LOCAL="/Users/nottvlike/Documents/program/android-ndk-r10b"
SKYNET_ROOT="/Users/nottvlike/Documents/github/slua/build/skynet/skynet"

cp slua.c skynet/jni/

cd skynet

$NDK_ROOT_LOCAL/ndk-build "NDK_MODULE_PATH=${SKYNET_ROOT}"

cp -f -R libs ../../Assets/Plugins/Android
cd ../