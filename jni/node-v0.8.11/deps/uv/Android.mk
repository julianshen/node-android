LOCAL_PATH:= $(call my-dir)

EV_CONFIG := \"config_android.h\"
EIO_CONFIG := \"config_android.h\"

local_src_files := \
	src/cares.c \
	src/fs-poll.c \
	src/uv-common.c \
	src/unix/async.c \
	src/unix/core.c \
	src/unix/dl.c \
	src/unix/error.c \
	src/unix/fs.c \
	src/unix/loop.c \
	src/unix/loop-watcher.c \
	src/unix/pipe.c \
	src/unix/poll.c \
	src/unix/process.c \
	src/unix/stream.c \
	src/unix/tcp.c \
	src/unix/thread.c \
	src/unix/timer.c \
	src/unix/tty.c \
	src/unix/udp.c \
	src/unix/uv-eio.c \
	src/unix/linux/inotify.c \
	src/unix/linux/linux-core.c \
	src/unix/linux/syscalls.c \
	src/unix/ev/ev.c \
	src/unix/ev/event.c \
	src/unix/eio/eio.c \
	src/ares/ares_cancel.c \
	src/ares/ares__close_sockets.c \
	src/ares/ares_data.c \
	src/ares/ares_destroy.c \
	src/ares/ares_expand_name.c \
	src/ares/ares_expand_string.c \
	src/ares/ares_fds.c \
	src/ares/ares_free_hostent.c \
	src/ares/ares_free_string.c \
	src/ares/ares_getenv.c \
	src/ares/ares_gethostbyaddr.c \
	src/ares/ares_gethostbyname.c \
	src/ares/ares__get_hostent.c \
	src/ares/ares_getnameinfo.c \
	src/ares/ares_getopt.c \
	src/ares/ares_getsock.c \
	src/ares/ares_init.c \
	src/ares/ares_library_init.c \
	src/ares/ares_llist.c \
	src/ares/ares_mkquery.c \
	src/ares/ares_nowarn.c \
	src/ares/ares_options.c \
	src/ares/ares_parse_aaaa_reply.c \
	src/ares/ares_parse_a_reply.c \
	src/ares/ares_parse_mx_reply.c \
	src/ares/ares_parse_ns_reply.c \
	src/ares/ares_parse_ptr_reply.c \
	src/ares/ares_parse_srv_reply.c \
	src/ares/ares_parse_txt_reply.c \
	src/ares/ares_platform.c \
	src/ares/ares_process.c \
	src/ares/ares_query.c \
	src/ares/ares__read_line.c \
	src/ares/ares_search.c \
	src/ares/ares_send.c \
	src/ares/ares_strcasecmp.c \
	src/ares/ares_strdup.c \
	src/ares/ares_strerror.c \
	src/ares/ares_timeout.c \
	src/ares/ares__timeval.c \
	src/ares/ares_version.c \
	src/ares/ares_writev.c \
	src/ares/bitncmp.c \
	src/ares/inet_net_pton.c \
	src/ares/inet_ntop.c 

local_c_includes :=\
	$(LOCAL_PATH)/include \
	$(LOCAL_PATH)/include/uv-private \
	$(LOCAL_PATH)/src \
	$(LOCAL_PATH)/src/unix \
	$(LOCAL_PATH)/src/ares/config_android

#######################################
# target static library
include $(CLEAR_VARS)


LOCAL_SRC_FILES += $(local_src_files) 
LOCAL_CFLAGS := -DNDEBUG -DEV_CONFIG_H=$(EV_CONFIG) -DEIO_CONFIG_H=$(EIO_CONFIG) -DHAVE_CONFIG_H=1 -DEIO_STACKSIZE=262144
LOCAL_C_INCLUDES += $(local_c_includes)

LOCAL_MODULE_TAGS := optional
LOCAL_MODULE:= libuv_static
include $(BUILD_STATIC_LIBRARY)

