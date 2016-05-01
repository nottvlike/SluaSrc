LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE := slua

LOCAL_SRC_FILES := slua.c \

LOCAL_C_INCLUDES := $(LOCAL_PATH) \
$(LOCAL_PATH)/../skynet/3rd/lua \
$(LOCAL_PATH)/../skynet/skynet-src \

LOCAL_SHARED_LIBRARIES := lua_static skynet_static lualib_static lpeg_static
include $(BUILD_SHARED_LIBRARY)
$(call import-module,3rd/lua) \
$(call import-module,3rd/lpeg)
$(call import-module,skynet-src) \
$(call import-module,lualib-src) \
