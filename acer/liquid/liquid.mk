#############################################################################
#                                                                           #
#     Acer liquid build file, based on codeaurora tree qsd8250_ffa          #
#                                                                           #
#     Created by Koudelka and xian1243                                      #
#                                                                           #
#############################################################################
#PRODUCT_COPY_FILES := \
#    device/acer/liquid/init.salsa.rc:root/init.salsa.rc

# Packages to include
PRODUCT_PACKAGES += \
FM \

# Check generic.mk/languages_full.mk to see what applications/languages are installed turns out all languages get included if I don't specify, but some seem to be missing the actuall translation.
$(call inherit-product, $(SRC_TARGET_DIR)/product/languages_full.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/generic.mk)
$(call inherit-product-if-exists, vendor/acer/liquid/liquid-vendor.mk)

# Enabling Ring Tones
include frameworks/base/data/sounds/OriginalAudio.mk

# Liquid uses high-density artwork where available
PRODUCT_LOCALES += hdpi

# Publish that we support the live wallpaper feature.
PRODUCT_COPY_FILES += \
frameworks/base/data/etc/handheld_core_hardware.xml:system/etc/permissions/handheld_core_hardware.xml \
frameworks/base/data/etc/android.hardware.camera.autofocus.xml:system/etc/permissions/android.hardware.camera.autofocus.xml \
frameworks/base/data/etc/android.hardware.telephony.gsm.xml:system/etc/permissions/android.hardware.telephony.gsm.xml \
frameworks/base/data/etc/android.hardware.location.gps.xml:system/etc/permissions/android.hardware.location.gps.xml \
frameworks/base/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
frameworks/base/data/etc/android.hardware.sensor.proximity.xml:system/etc/permissions/android.hardware.sensor.proximity.xml \
frameworks/base/data/etc/android.hardware.sensor.light.xml:system/etc/permissions/android.hardware.sensor.light.xml \
frameworks/base/data/etc/android.hardware.touchscreen.multitouch.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.xml \

# Overrides
PRODUCT_BRAND := acer
PRODUCT_NAME := a1_generic1
PRODUCT_DEVICE := a1
PRODUCT_MODEL := Liquid
PRODUCT_MANUFACTURER := Acer

# Additional settings used in AOSP builds
PRODUCT_PROPERTY_OVERRIDES += \
    keyguard.no_require_sim=true \
    ro.com.android.dateformat=MM-dd-yyyy \
    ro.com.android.dataroaming=false \
    ro.sf.lcd_density=240 \
    rild.libpath=/system/lib/libril-acer-1.so \
    rild.libargs=-d /dev/smd0 \
    persist.rild.nitz_plmn= \
    persist.rild.nitz_long_ons_0= \
    persist.rild.nitz_long_ons_1= \
    persist.rild.nitz_long_ons_2= \
    persist.rild.nitz_long_ons_3= \
    persist.rild.nitz_short_ons_0= \
    persist.rild.nitz_short_ons_1= \
    persist.rild.nitz_short_ons_2= \
    persist.rild.nitz_short_ons_3= \
    persist.radio.skippable.mcclist=466,505 \
    persist.cust.tel.eons=1 \
    persist.ril.ecclist=000,08,110,112,118,119,911,999 \
    ro.ril.hsxpa=1 \
    ro.ril.gprsclass=10

# Acer specific proximity sensor calibration
PRODUCT_PROPERTY_OVERRIDES += \
    hw.acer.psensor_thres=500 \
    hw.acer.lsensor_multiplier=-1 \
    hw.acer.psensor_mode=1

# Acer hardware revision
PRODUCT_PROPERTY_OVERRIDES += \
    ro.hw_version=4

# Speed up scrolling
PRODUCT_PROPERTY_OVERRIDES += \
    windowsmgr.max_events_per_sec=60

# Default network type.
# 0 => WCDMA preferred, 3 => GSM/AUTO (PRL) preferred
PRODUCT_PROPERTY_OVERRIDES += \
    ro.telephony.default_network=3

# WiFi configuration
PRODUCT_PROPERTY_OVERRIDES += \
    wifi.interface=eth0 \
    wifi.supplicant_scan_interval=15

# The OpenGL ES API level that is natively supported by this device.
# This is a 16.16 fixed point number
PRODUCT_PROPERTY_OVERRIDES += \
    ro.opengles.version=131072

# This is a high density device with more memory, so larger vm heaps for it.
PRODUCT_PROPERTY_OVERRIDES += \
    dalvik.vm.heapsize=32m
