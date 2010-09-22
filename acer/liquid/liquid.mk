#############################################################################
#                                                                           #
#     Acer liquid build file, based on codeaurora tree qsd8250_ffa          #
#                                                                           #
#     Created by Koudelka and xian1243                                      #
#                                                                           #
#############################################################################
#PRODUCT_COPY_FILES := \
#    device/acer/liquid/init.salsa.rc:root/init.salsa.rc

# Check generic.mk/languages_full.mk to see what applications/languages are installed turns out all languages get included if I don't specify, but some seem to be missing the actuall translation.
$(call inherit-product, $(SRC_TARGET_DIR)/product/languages_full.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/generic.mk)

# Liquid uses high-density artwork where available
PRODUCT_LOCALES += hdpi

# Enabling Ring Tones
include frameworks/base/data/sounds/OriginalAudio.mk

# Live wallpaper packages
PRODUCT_PACKAGES := \
LiveWallpapers \
LiveWallpapersPicker \
MagicSmokeWallpapers \
VisualizationWallpapers \
librs_jni

# Pick up overlay for features that depend on non-open-source files
DEVICE_PACKAGE_OVERLAYS := vendor/acer/liquid/overlay

# Publish that we support the live wallpaper feature.
PRODUCT_COPY_FILES := \
packages/wallpapers/LivePicker/android.software.live_wallpaper.xml:/system/etc/permissions/android.software.live_wallpaper.xml

# Overrides
PRODUCT_BRAND := acer
PRODUCT_NAME := a1_generic1
PRODUCT_DEVICE := a1
PRODUCT_MODEL := Liquid
PRODUCT_MANUFACTURER := Acer

# Additional settings used in AOSP builds
PRODUCT_PROPERTY_OVERRIDES := \
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
PRODUCT_PROPERTY_OVERRIDES := \
    persist.sys.psensor_base=2.3710938
    hw.acer.psensor_calib_max_base=32707 \
    hw.acer.psensor_calib_min_base=7439 \
    hw.acer.psensor_thres=500 \
    hw.acer.lsensor_multiplier=-1 \
    hw.acer.psensor_mode=1

# Acer hardware revision
PRODUCT_PROPERTY_OVERRIDES := \
    ro.hw_version=4

# Default network type.
# 0 => WCDMA preferred, 3 => GSM/AUTO (PRL) preferred
PRODUCT_PROPERTY_OVERRIDES := \
    ro.telephony.default_network=3

# WiFi configuration
PRODUCT_PROPERTY_OVERRIDES := \
    wifi.interface=eth0 \
    wifi.supplicant_scan_interval=15

# The OpenGL ES API level that is natively supported by this device.
# This is a 16.16 fixed point number
PRODUCT_PROPERTY_OVERRIDES := \
    ro.opengles.version=131072

# This is a high density device with more memory, so larger vm heaps for it.
PRODUCT_PROPERTY_OVERRIDES := \
    dalvik.vm.heapsize=32m

# Prebuilt libraries that are needed to build open-source libraries
PRODUCT_COPY_FILES += \
device/acer/liquid/proprietary/lib/libgps.so:obj/lib/libgps.so \
device/acer/liquid/proprietary/lib/libcamera.so:obj/lib/libcamera.so \
device/acer/liquid/proprietary/lib/liboemcamera.so:obj/lib/liboemcamera.so

# All the blobs necessary for liquid
# Copy EGL libraries
PRODUCT_COPY_FILES += \
device/acer/liquid/proprietary/lib/libril-acer-1.so:system/lib/libril-acer-1.so \
device/acer/liquid/proprietary/lib/libril-acerril-hook-oem.so:system/lib/libril-acerril-hook-oem.so

# Copy EGL libraries
PRODUCT_COPY_FILES += \
device/acer/liquid/proprietary/lib/libEGL_adreno200.so:system/lib/egl/libEGL_adreno200.so \
device/acer/liquid/proprietary/lib/libGLESv1_CM_adreno200.so:system/lib/egl/libGLESv1_CM_adreno200.so \
device/acer/liquid/proprietary/lib/libGLESv2_adreno200.so:system/lib/egl/libGLESv2_adreno200.so \
device/acer/liquid/proprietary/lib/libq3dtools_adreno200.so:system/lib/egl/libq3dtools_adreno200.so \
device/acer/liquid/proprietary/lib/libgsl.so:system/lib/libgsl.so

#Copy camera libraries
PRODUCT_COPY_FILES += \
device/acer/liquid/proprietary/lib/libcamera.so:system/lib/libcamera.so \
device/acer/liquid/proprietary/lib/liboemcamera.so:system/lib/liboemcamera.so \
device/acer/liquid/proprietary/lib/libmmipl.so:system/lib/libmmipl.so \
device/acer/liquid/proprietary/lib/libmmjpeg.so:system/lib/libmmjpeg.so

# Copy dhcpd (need to chmod dhcpcd-eth0.pid upon flashing)
PRODUCT_COPY_FILES += \
device/acer/liquid/proprietary/etc/dhcpcd/dhcpcd.conf:system/etc/dhcpcd/dhcpcd.conf \
device/acer/liquid/proprietary/etc/dhcpcd/dhcpcd-run-hooks:system/etc/dhcpcd/dhcpcd-run-hooks \
device/acer/liquid/proprietary/etc/dhcpcd/dhcpcd-hooks/01-test:system/etc/dhcpcd/dhcpcd-hooks/01-test \
device/acer/liquid/proprietary/etc/dhcpcd/dhcpcd-hooks/20-dns.conf:system/etc/dhcpcd/dhcpcd-hooks/20-dns.conf \
device/acer/liquid/proprietary/etc/dhcpcd/dhcpcd-hooks/95-configured:system/etc/dhcpcd/dhcpcd-hooks/95-configured \
device/acer/liquid/proprietary/data/misc/dhcp/dhcpcd-eth0.pid:data/misc/dhcp/dhcpcd-eth0.pid

# Copy GPS libraries and dependencies
PRODUCT_COPY_FILES += \
device/acer/liquid/proprietary/lib/ibloc.so:system/lib/libloc.so \
device/acer/liquid/proprietary/lib/libloc-rpc.so:system/lib/libloc-rpc.so \
device/acer/liquid/proprietary/lib/libloc_api.so:system/lib/libloc_api.so \
device/acer/liquid/proprietary/lib/libcommondefs.so:system/lib/libcommondefs.so \
device/acer/liquid/proprietary/lib/libgps.so:system/lib/libgps.so

# Copy WiFi firmware and config
PRODUCT_COPY_FILES += \
device/acer/liquid/proprietary/etc/firmware/BCM4325.hcd:system/etc/firmware/BCM4325.hcd \
device/acer/liquid/proprietary/etc/firmware/BCM4325.bin:system/etc/firmware/BCM4325.bin \
device/acer/liquid/proprietary/etc/firmware/BCM4325_apsta.bin:system/etc/firmware/BCM4325_apsta.bin \
device/acer/liquid/proprietary/etc/wifi/nvram.txt:system/etc/wifi/nvram.txt \
device/acer/liquid/proprietary/etc/wifi/wpa_supplicant.conf:system/etc/wifi/wpa_supplicant.conf

# Copy Vold and configs
PRODUCT_COPY_FILES += \
device/acer/liquid/proprietary/etc/vold.fstab:system/etc/vold.fstab \
device/acer/liquid/proprietary/etc/vold.conf:system/etc/vold.conf \
device/acer/liquid/proprietary/bin/vold:system/bin/vold

# Copy sensor library, binary and configuration (need to chmod ms3c_yamaha.cfg upon flashing for yamaha sensor to function properly)
PRODUCT_COPY_FILES += \
device/acer/liquid/proprietary/etc/firmware/yamato_pfp.fw:system/etc/firmware/yamato_pfp.fw \
device/acer/liquid/proprietary/etc/firmware/yamato_pm4.fw:system/etc/firmware/yamato_pm4.fw \
device/acer/liquid/proprietary/lib/sensors.salsa.so:system/lib/hw/sensors.salsa.so \
device/acer/liquid/proprietary/lib/libsensor_yamaha.so:system/lib/libsensor_yamaha.so \
device/acer/liquid/proprietary/lib/libms3c_yamaha.so:system/lib/libms3c_yamaha.so \
device/acer/liquid/proprietary/bin/sensorcalibutil_yamaha:system/bin/sensorcalibutil_yamaha \
device/acer/liquid/proprietary/bin/sensorserver_yamaha:system/bin/sensorserver_yamaha \
device/acer/liquid/proprietary/bin/sensorstatutil_yamaha:system/bin/sensorstatutil_yamaha \
device/acer/liquid/proprietary/data/system/ms3c_yamaha.cfg:data/system/ms3c_yamaha.cfg

# Copy Acer keylayout and headset driver
PRODUCT_COPY_FILES += \
device/acer/liquid/proprietary/usr/keylayout/a1-keypad.kl:system/usr/keylayout/a1-keypad.kl \
device/acer/liquid/proprietary/usr/keylayout/h2w_headset.kl:system/usr/keylayout/h2w_headset.kl \
device/acer/liquid/proprietary/usr/keylayout/acer-hs-butt.kl:system/usr/keylayout/acer-hs-butt.kl \
device/acer/liquid/proprietary/usr/keylayout/AVRCP.kl:system/usr/keylayout/AVRCP.kl \
device/acer/liquid/proprietary/usr/keylayout/qwerty.kl:system/usr/keylayout/qwerty.kl