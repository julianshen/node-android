LOCAL_PATH:= $(call my-dir)

include $(CLEAR_VARS)

NODE_VERSION:= 0.8.11
NODE_PATH := node-v$(NODE_VERSION)
NODE_DEP_PATH := $(NODE_PATH)/deps
PREBUILT_EXEC_PATH := $(LOCAL_PATH)/prebuilt/$(HOST_OS)/sbin

$(info HOST OS: $(HOST_OS) TARGET ARCH : $(TARGET_ARCH))
include $(NODE_DEP_PATH)/openssl/openssl/Android.mk
include $(NODE_DEP_PATH)/zlib/Android.mk
include $(NODE_DEP_PATH)/http_parser/Android.mk
include $(NODE_DEP_PATH)/uv/Android.mk

#for V8
ENABLE_V8_SNAPSHOT = false
include $(NODE_DEP_PATH)/v8/Android.libv8.mk
#include $(NODE_DEP_PATH)/v8/Android.v8shell.mk

#node.js
include $(NODE_PATH)/Android.mk
