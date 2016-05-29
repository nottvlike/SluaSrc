LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE := slua

LOCAL_SRC_FILES := slua.c \
FileHelperAndroid.cpp \

LOCAL_C_INCLUDES := $(LOCAL_PATH) \
$(LOCAL_PATH)/../skynet/3rd/lua \
$(LOCAL_PATH)/../skynet/skynet-src \

LOCAL_STATIC_LIBRARIES := lua_static lualib_static lpeg_static
LOCAL_LDLIBS += -landroid -llog

include $(BUILD_SHARED_LIBRARY)
$(call import-module,3rd/lua) \
$(call import-module,3rd/lpeg)
$(call import-module,lualib-src) \
