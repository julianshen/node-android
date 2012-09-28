##
LOCAL_PATH := $(call my-dir)
# libv8.so
# ===================================================
include $(CLEAR_VARS)

#include external/stlport/libstlport.mk

# Set up the target identity
LOCAL_MODULE := libv8
LOCAL_MODULE_CLASS := STATIC_LIBRARIES
intermediates := $(call local-intermediates-dir)

PRIVATE_CLEAN_FILES := $(HOST_OUT)/bin/mksnapshot \
    $(HOST_OUT)/obj/EXECUTABLES/mksnapshot_intermediates

# Android.v8common.mk defines common V8_LOCAL_SRC_FILES
# and V8_LOCAL_JS_LIBRARY_FILES
V8_LOCAL_SRC_FILES :=
V8_LOCAL_JS_LIBRARY_FILES :=
V8_LOCAL_JS_EXPERIMENTAL_LIBRARY_FILES :=
include $(LOCAL_PATH)/Android.v8common.mk

# Target can only be linux
V8_LOCAL_SRC_FILES += \
  src/platform-linux.cc \
  src/platform-posix.cc

ifeq ($(TARGET_ARCH),x86)
V8_LOCAL_SRC_FILES += src/atomicops_internals_x86_gcc.cc
endif

LOCAL_SRC_FILES := $(V8_LOCAL_SRC_FILES)

LOCAL_JS_LIBRARY_FILES := $(addprefix $(LOCAL_PATH)/, $(V8_LOCAL_JS_LIBRARY_FILES))
LOCAL_JS_EXPERIMENTAL_LIBRARY_FILES := $(addprefix $(LOCAL_PATH)/, $(V8_LOCAL_JS_EXPERIMENTAL_LIBRARY_FILES))

# Copy js2c.py to intermediates directory and invoke there to avoid generating
# jsmin.pyc in the source directory
#JS2C_PY := $(intermediates)/js2c.py $(intermediates)/jsmin.py
JS2C_PY := $(LOCAL_PATH)/tools/js2c.py
#$(JS2C_PY): $(intermediates)/%.py : $(LOCAL_PATH)/tools/%.py | $(ACP)
#	@echo "Copying $@"
#	$(copy-file-to-target)


# Generate libraries.cc
GEN1 := $(LOCAL_PATH)/src/gen-libraries.cc
#$(GEN1): SCRIPT := $(intermediates)/js2c.py
#$(GEN1): $(LOCAL_JS_LIBRARY_FILES) $(JS2C_PY)
#	@echo "Generating libraries.cc"
#	@mkdir -p $(dir $@)
#	python $(SCRIPT) $(GEN1) CORE off $(LOCAL_JS_LIBRARY_FILES)
#V8_GENERATED_LIBRARIES := $(intermediates)/libraries.cc

LOCAL_SRC_FILES += src/gen-libraries.cc

# Generate experimental-libraries.cc
GEN2 := $(LOCAL_PATH)/src/gen-experimental-libraries.cc
#$(GEN2): SCRIPT := $(intermediates)/js2c.py
#$(GEN2): $(LOCAL_JS_EXPERIMENTAL_LIBRARY_FILES) $(JS2C_PY)
#	@echo "Generating experimental-libraries.cc"
#	@mkdir -p $(dir $@)
#	python $(SCRIPT) $(GEN2) EXPERIMENTAL off $(LOCAL_JS_EXPERIMENTAL_LIBRARY_FILES)
#V8_GENERATED_LIBRARIES += $(intermediates)/experimental-libraries.cc

#LOCAL_GENERATED_SOURCES += $(V8_GENERATED_LIBRARIES)

LOCAL_SRC_FILES += src/gen-experimental-libraries.cc

# Generate snapshot.cc
ifeq ($(ENABLE_V8_SNAPSHOT),true)
SNAP_GEN := $(LOCAL_PATH)/src/gen-snapshot.cc
MKSNAPSHOT := $(PREBUILT_EXEC_PATH)/mksnapshot
#$(SNAP_GEN): PRIVATE_CUSTOM_TOOL = $(MKSNAPSHOT) --logfile $(intermediates)/v8.log $(SNAP_GEN)
$(shell $(MKSNAPSHOT) --logfile $(TARGET_OUT)/v8.log $(SNAP_GEN))

LOCAL_SRC_FILES += src/gen-snapshot.cc
else
LOCAL_SRC_FILES += \
  src/snapshot-empty.cc
endif

# The -fvisibility=hidden option below prevents exporting of symbols from
# libv8.a in libwebcore.so.  That reduces size of libwebcore.so by 500k.
LOCAL_CFLAGS += \
	-Wno-endif-labels \
	-Wno-import \
	-Wno-format \
	-fno-exceptions \
	-fvisibility=hidden \
	-DENABLE_DEBUGGER_SUPPORT \
	-DENABLE_LOGGING_AND_PROFILING \
	-DENABLE_VMSTATE_TRACKING \
	-DV8_NATIVE_REGEXP

ifeq ($(TARGET_ARCH),arm)
	LOCAL_CFLAGS += -DARM -DV8_TARGET_ARCH_ARM
endif

ifeq ($(TARGET_ARCH),x86)
	LOCAL_CFLAGS += -DV8_TARGET_ARCH_IA32
endif

ifeq ($(DEBUG_V8),true)
	LOCAL_CFLAGS += -DDEBUG -UNDEBUG
endif


$(info Generating $(GEN1))
$(shell python $(JS2C_PY) $(GEN1) CORE off $(LOCAL_JS_LIBRARY_FILES))
$(info Generating $(GEN2))
$(shell python $(JS2C_PY) $(GEN2) EXPERIMENTAL off $(LOCAL_JS_EXPERIMENTAL_LIBRARY_FILES))

LOCAL_C_INCLUDES += $(LOCAL_PATH)/src

include $(BUILD_STATIC_LIBRARY)
