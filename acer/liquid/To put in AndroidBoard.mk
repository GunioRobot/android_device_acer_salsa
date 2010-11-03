# To put in AndroidBoard.mk for building Salsa ramdisk
file := $(TARGET_ROOT_OUT)/init.salsa.rc
ALL_PREBUILT += $(file)
$(file) : $(LOCAL_PATH)/init.salsa.rc | $(ACP)
$(transform-prebuilt-to-target)

file := $(TARGET_ROOT_OUT)/default.prop
ALL_PREBUILT += $(file)
$(file) : $(LOCAL_PATH)/default.prop | $(ACP)
$(transform-prebuilt-to-target)

file := $(TARGET_ROOT_OUT)/init.goldfish.rc
ALL_PREBUILT += $(file)
$(file) : $(LOCAL_PATH)/init.goldfish.rc | $(ACP)
$(transform-prebuilt-to-target)

file := $(TARGET_ROOT_OUT)/init.rc
ALL_PREBUILT += $(file)
$(file) : $(LOCAL_PATH)/init.rc | $(ACP)
$(transform-prebuilt-to-target)

file := $(TARGET_ROOT_OUT)/init.salsa.sh
ALL_PREBUILT += $(file)
$(file) : $(LOCAL_PATH)/init.salsa.sh | $(ACP)
$(transform-prebuilt-to-target)

file := $(TARGET_ROOT_OUT)/initlogo.rle
ALL_PREBUILT += $(file)
$(file) : $(LOCAL_PATH)/initlogo.rle | $(ACP)
$(transform-prebuilt-to-target)

file := $(TARGET_ROOT_OUT)/sbin/mountbind.sh
ALL_PREBUILT += $(file)
$(file) : $(LOCAL_PATH)/sbin/mountbind.sh | $(ACP)
$(transform-prebuilt-to-target)

file := $(TARGET_ROOT_OUT)/sbin/qmuxd.sh
ALL_PREBUILT += $(file)
$(file) : $(LOCAL_PATH)/sbin/qmuxd.sh | $(ACP)
$(transform-prebuilt-to-target)

file := $(TARGET_ROOT_OUT)/sbin/rild.sh
ALL_PREBUILT += $(file)
$(file) : $(LOCAL_PATH)/sbin/rild.sh | $(ACP)
$(transform-prebuilt-to-target)
