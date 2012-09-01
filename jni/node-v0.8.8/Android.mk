LOCAL_PATH:= $(call my-dir)

gen_path := \
	$(TARGET_OUT)/gen

local_src_files := \
	src/cares_wrap.cc \
	src/fs_event_wrap.cc \
	src/handle_wrap.cc \
	src/node.cc \
	src/node_buffer.cc \
	src/node_constants.cc \
	src/node_crypto.cc \
	src/node_extensions.cc \
	src/node_file.cc \
	src/node_http_parser.cc \
	src/node_io_watcher.cc \
	src/node_javascript.cc \
	src/node_os.cc \
	src/node_script.cc \
	src/node_signal_watcher.cc \
	src/node_stat_watcher.cc \
	src/node_string.cc \
	src/node_zlib.cc \
	src/pipe_wrap.cc \
	src/process_wrap.cc \
	src/slab_allocator.cc \
	src/stream_wrap.cc \
	src/tcp_wrap.cc \
	src/timer_wrap.cc \
	src/tty_wrap.cc \
	src/udp_wrap.cc \
	src/v8_typed_array.cc \
	android/node_android.cc

local_node_main_src = \
	src/node_main.cc 

local_c_includes := \
	$(LOCAL_PATH)/deps/v8/include \
	$(LOCAL_PATH)/deps/uv/include \
	$(LOCAL_PATH)/deps/uv/include/uv-private \
	$(LOCAL_PATH)/deps/http_parser \
	$(LOCAL_PATH)/deps/uv/src \
	$(LOCAL_PATH)/deps/uv/src/ares \
	$(LOCAL_PATH)/deps/uv/src/unix \
	$(LOCAL_PATH)/deps/uv/src/unix/ev \
	$(LOCAL_PATH)/deps/uv/src/unix/eio \
	$(LOCAL_PATH)/deps/openssl/config/android/ \
	$(LOCAL_PATH)/deps/openssl/openssl/include \
	$(LOCAL_PATH)/src \
	$(LOCAL_PATH)/android \
	$(gen_path)
	

local_c_flags := \
	-DHAVE_OPENSSL=1 \
	-DNODE_WANT_INTERNALS=1 \
	-D__POSIX__ \
	-DARCH=\"$(TARGET_ARCH)\" \
	-DPLATFORM=\"android\" \
	-DHAVE_CONFIG_H=1 
	
local_js_files := \
	$(LOCAL_PATH)/src/node.js \
	$(LOCAL_PATH)/lib/_debugger.js \
	$(LOCAL_PATH)/lib/_linklist.js \
	$(LOCAL_PATH)/lib/assert.js \
	$(LOCAL_PATH)/lib/buffer.js \
	$(LOCAL_PATH)/lib/buffer_ieee754.js \
	$(LOCAL_PATH)/lib/child_process.js \
	$(LOCAL_PATH)/lib/cluster.js \
	$(LOCAL_PATH)/lib/console.js \
	$(LOCAL_PATH)/lib/constants.js \
	$(LOCAL_PATH)/lib/crypto.js \
	$(LOCAL_PATH)/lib/dgram.js \
	$(LOCAL_PATH)/lib/dns.js \
	$(LOCAL_PATH)/lib/domain.js \
	$(LOCAL_PATH)/lib/events.js \
	$(LOCAL_PATH)/lib/freelist.js \
	$(LOCAL_PATH)/lib/fs.js \
	$(LOCAL_PATH)/lib/http.js \
	$(LOCAL_PATH)/lib/https.js \
	$(LOCAL_PATH)/lib/module.js \
	$(LOCAL_PATH)/lib/net.js \
	$(LOCAL_PATH)/lib/os.js \
	$(LOCAL_PATH)/lib/path.js \
	$(LOCAL_PATH)/lib/punycode.js \
	$(LOCAL_PATH)/lib/querystring.js \
	$(LOCAL_PATH)/lib/readline.js \
	$(LOCAL_PATH)/lib/repl.js \
	$(LOCAL_PATH)/lib/stream.js \
	$(LOCAL_PATH)/lib/string_decoder.js \
	$(LOCAL_PATH)/lib/sys.js \
	$(LOCAL_PATH)/lib/timers.js \
	$(LOCAL_PATH)/lib/tls.js \
	$(LOCAL_PATH)/lib/tty.js \
	$(LOCAL_PATH)/lib/url.js \
	$(LOCAL_PATH)/lib/util.js \
	$(LOCAL_PATH)/lib/vm.js \
	$(LOCAL_PATH)/lib/zlib.js \
	$(LOCAL_PATH)/android/android.js

local_js_files += $(LOCAL_PATH)/config.gypi

#######################################
# target node executeable
include $(CLEAR_VARS)

#generate node_natives.h
$(shell mkdir -p $(gen_path))
$(shell python $(LOCAL_PATH)/tools/js2c.py $(gen_path)/node_natives.h $(local_js_files))

LOCAL_CPP_EXTENSION := .cc
LOCAL_SRC_FILES += $(local_src_files) 
LOCAL_CFLAGS += $(local_c_flags)
LOCAL_C_INCLUDES += $(local_c_includes)

LOCAL_MODULE_TAGS := optional
LOCAL_MODULE := libnode_static

include $(BUILD_STATIC_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE := node

LOCAL_CPP_EXTENSION := .cc
LOCAL_SRC_FILES += $(local_node_main_src)
LOCAL_CFLAGS += $(local_c_flags)
LOCAL_C_INCLUDES += $(local_c_includes)
LOCAL_STATIC_LIBRARIES := libnode_static libuv_static libssl_static libcrypto_static libv8 libhttpparser_static libz
LOCAL_LDLIBS    += -llog

include $(BUILD_EXECUTABLE)
