LOCAL_PATH:= $(call my-dir)


local_src_files := \
	http_parser.c


#######################################
# target static library
include $(CLEAR_VARS)


LOCAL_SRC_FILES += $(local_src_files) 
LOCAL_CFLAGS += $(local_c_flags)
LOCAL_C_INCLUDES += $(local_c_includes)

LOCAL_MODULE_TAGS := optional
LOCAL_MODULE:= libhttpparser_static
include $(BUILD_STATIC_LIBRARY)

