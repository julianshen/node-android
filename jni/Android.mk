LOCAL_PATH:= $(call my-dir)

include $(CLEAR_VARS)

NODE_PATH := $(LOCAL_PATH)/node-latest
NODE_STATIC_LIB_PATH := $(NODE_PATH)/out/Release
NODE_INC_PATH := $(NODE_PATH)/src
NODE_OBJ_PATH := $(NODE_STATIC_LIB_PATH)/obj.target/node/src

include $(CLEAR_VARS)
LOCAL_MODULE := libuv
LOCAL_SRC_FILES := $(NODE_STATIC_LIB_PATH)/libuv.a
include $(PREBUILT_STATIC_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE := libcares
LOCAL_SRC_FILES := $(NODE_STATIC_LIB_PATH)/libcares.a
include $(PREBUILT_STATIC_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE := libchrome_zlib
LOCAL_SRC_FILES := $(NODE_STATIC_LIB_PATH)/libchrome_zlib.a
include $(PREBUILT_STATIC_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE := libv8_base.arm
LOCAL_SRC_FILES := $(NODE_STATIC_LIB_PATH)/libv8_base.arm.a
include $(PREBUILT_STATIC_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE := libhttp_parser
LOCAL_SRC_FILES := $(NODE_STATIC_LIB_PATH)/libhttp_parser.a
include $(PREBUILT_STATIC_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE := libv8_nosnapshot.arm
LOCAL_SRC_FILES := $(NODE_STATIC_LIB_PATH)/libv8_nosnapshot.arm.a
include $(PREBUILT_STATIC_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE := libopenssl
LOCAL_SRC_FILES := $(NODE_STATIC_LIB_PATH)/libopenssl.a
include $(PREBUILT_STATIC_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE := libnode
LOCAL_SRC_FILES := $(NODE_PATH)/libnode.a
include $(PREBUILT_STATIC_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE    := nodeJNI

LOCAL_C_INCLUDES := $(NODE_INC_PATH) $(NODE_PATH)/deps/v8/include jni-bridge
LOCAL_WHOLE_STATIC_LIBRARIES := node
LOCAL_STATIC_LIBRARIES := uv cares chrome_zlib v8_base.arm http_parser v8_nosnapshot.arm openssl
LOCAL_LDLIBS := -llog -landroid 

LOCAL_SRC_FILES := jni-bridge/node_jni.cc \

include $(BUILD_SHARED_LIBRARY)
