#############################################################################
#                                                                           #
#     Acer liquid build file, based on codeaurora tree qsd8250_ffa          #
#                                                                           #
#     Created by Koudelka and xian1243                                      #
#                                                                           #
#############################################################################
#                                                                           #
#     Need to chmod                                                         #
#                                                                           #
#############################################################################
PRODUCT_PACKAGES := \
    Email \
    IM \
    VoiceDialer \
    GoogleContactsProvider \
    LiveWallpapers \
    LiveWallpapersPicker \
    MagicSmokeWallpapers \
    VisualizationWallpapers

#check generik.mk/languages_full.mk to see what applications/languages are installed
#turns out all languages get included if I don't specify, but some seem to be missing the actuall translation
#$(call inherit-product, build/target/product/languages_full.mk)

$(call inherit-product, build/target/product/generic.mk)

# Liquid uses high-density artwork where available
PRODUCT_LOCALES += hdpi

# Enabling Ring Tones
include frameworks/base/data/sounds/OriginalAudio.mk

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
    ro.com.android.dataroaming=true \
    ro.ril.hsxpa=1 \
    ro.ril.gprsclass=10 \
    ro.hw_version=4
    hw.acer.psensor_calib_max_base=32707
    hw.acer.psensor_calib_min_base=7439
    hw.acer.psensor_thres=500
    hw.acer.lsensor_multiplier=-1
    hw.acer.psensor_mode=1
    ro.telephony.default_network=3
    wifi.interface=eth0 \
    wifi.supplicant_scan_interval=15

#Copy configuration files
PRODUCT_COPY_FILES += \
   device/acer/liquid/proprietary/etc/vold.fstab:system/etc/vold.fstab \
   device/acer/liquid/proprietary/etc/vold.conf:system/etc/vold.conf \
   device/acer/liquid/proprietary/etc/gps.conf:system/etc/gps.conf \

#Copy Acer keylayout
PRODUCT_COPY_FILES += \
   device/acer/liquid/proprietary/usr/keylayout/a1-keypad.kl:system/usr/keylayout/ \
   device/acer/liquid/proprietary/usr/keylayout/h2w_headset.kl:system/usr/keylayout/ \
   device/acer/liquid/proprietary/usr/keylayout/acer-hs-butt.kl:system/usr/keylayout/ \
   device/acer/liquid/proprietary/usr/keylayout/AVRCP.kl:system/usr/keylayout/ \
   device/acer/liquid/proprietary/usr/keylayout/qwerty.kl:system/usr/keylayout/ 

#Copy permissions
PRODUCT_COPY_FILES += \
    frameworks/base/data/etc/handheld_core_hardware.xml:system/etc/permissions/handheld_core_hardware.xml \
    frameworks/base/data/etc/android.hardware.camera.flash-autofocus.xml:system/etc/permissions/android.hardware.camera.flash-autofocus.xml \
    frameworks/base/data/etc/android.hardware.telephony.gsm.xml:system/etc/permissions/android.hardware.telephony.gsm.xml \
    frameworks/base/data/etc/android.hardware.location.gps.xml:system/etc/permissions/android.hardware.location.gps.xml \
    frameworks/base/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
    frameworks/base/data/etc/android.hardware.sensor.proximity.xml:system/etc/permissions/android.hardware.sensor.proximity.xml \
    frameworks/base/data/etc/android.hardware.sensor.light.xml:system/etc/permissions/android.hardware.sensor.light.xml \
    frameworks/base/data/etc/android.hardware.touchscreen.multitouch.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.xml

#Copy Bluetooth & WiFi firmwares and configurations
PRODUCT_COPY_FILES += \
   device/acer/liquid/proprietary/etc/firmware/BCM4325.hcd:system/etc/firmware/BCM4325.hcd \
   device/acer/liquid/proprietary/etc/firmware/BCM4325.bin:system/etc/firmware/BCM4325.bin \
   device/acer/liquid/proprietary/etc/firmware/BCM4325_apsta.bin:system/etc/firmware/BCM4325_apsta.bin \
   device/acer/liquid/proprietary/etc/wifi/nvram.txt:system/etc/wifi/nvram.txt \
   device/acer/liquid/proprietary/etc/wifi/wpa_supplicant.conf:system/etc/wifi/wpa_supplicant.conf
  

#Copy dhcpd (need to chmod dhcpcd-eth0.pid upon flashing)
PRODUCT_COPY_FILES += \
   device/acer/liquid/proprietary/etc/dhcpcd/dhcpcd.conf:system/etc/dhcpcd/dhcpcd.conf \
   device/acer/liquid/proprietary/etc/dhcpcd/dhcpcd-run-hooks:system/etc/dhcpcd/dhcpcd-run-hooks \
   device/acer/liquid/proprietary/etc/dhcpcd/dhcpcd-hooks/01-test:system/etc/dhcpcd/dhcpcd-hooks/01-test \
   device/acer/liquid/proprietary/etc/dhcpcd/dhcpcd-hooks/20-dns.conf:system/etc/dhcpcd/dhcpcd-hooks/20-dns.conf \
device/acer/liquid/proprietary/etc/dhcpcd/dhcpcd-hooks/95-configured:system/etc/dhcpcd/dhcpcd-hooks/95-configured \
   device/acer/liquid/proprietary/data/misc/dhcp/dhcpcd-eth0.pid:data/misc/dhcp/dhcpcd-eth0.pid

#Copy sensor library, binary and configuration (need to chmod ms3c_yamaha.cfg upon flashing for yamaha sensor to function properly)
PRODUCT_COPY_FILES += \
   device/acer/liquid/proprietary/lib/hw/sensors.salsa.so:system/lib/hw/sensors.salsa.so \
   device/acer/liquid/proprietary/lib/hw/lights.salsa.so:system/lib/hw/lights.salsa.so \
   device/acer/liquid/proprietary/lib/libsensor_yamaha.so:system/lib/libsensor_yamaha.so \
   device/acer/liquid/proprietary/lib/libms3c_yamaha.so:system/lib/libms3c_yamaha.so \
   device/acer/liquid/proprietary/bin/sensorcalibutil_yamaha:system/bin/sensorcalibutil_yamaha \
   device/acer/liquid/proprietary/bin/sensorserver_yamaha:system/bin/sensorserver_yamaha \
   device/acer/liquid/proprietary/bin/sensorstatutil_yamaha:system/bin/sensorstatutil_yamaha \
   device/acer/liquid/proprietary/data/system/ms3c_yamaha.cfg:data/system/ms3c_yamaha.cfg

#Copy GPS libraries and dependencies
PRODUCT_COPY_FILES += \
   device/acer/liquid/proprietary/lib/libloc.so:system/lib/libloc.so \
   device/acer/liquid/proprietary/lib/libloc.so:obj/lib/libloc.so \
   device/acer/liquid/proprietary/lib/libloc-rpc.so:system/lib/libloc-rpc.so \
   device/acer/liquid/proprietary/lib/libloc-rpc.so:obj/lib/libloc-rpc.so \
   device/acer/liquid/proprietary/lib/libcommondefs.so:system/lib/libcommondefs.so \
   device/acer/liquid/proprietary/lib/libcommondefs.so:obj/lib/libcommondefs.so \
   device/acer/liquid/proprietary/lib/libgps.so:system/lib/libgps.so \
   device/acer/liquid/proprietary/lib/libgps.so:obj/lib/libgps.so

#Copy EGL libraries
PRODUCT_COPY_FILES += \
   device/acer/liquid/proprietary/lib/egl/libEGL_adreno200.so:system/lib/egl/libEGL_adreno200.so \
   device/acer/liquid/proprietary/lib/egl/libGLESv1_CM_adreno200.so:system/lib/egl/libGLESv1_CM_adreno200.so \
   device/acer/liquid/proprietary/lib/egl/libGLESv2_adreno200.so:system/lib/egl/libGLESv2_adreno200.so \
   device/acer/liquid/proprietary/lib/egl/libq3dtools_adreno200.so:system/lib/egl/libq3dtools_adreno200.so \
   device/acer/liquid/proprietary/lib/libgsl.so:system/lib/libgsl.so \
   device/acer/liquid/proprietary/etc/firmware/yamato_pfp.fw:system/etc/firmware/yamato_pfp.fw \
   device/acer/liquid/proprietary/etc/firmware/yamato_pm4.fw:system/etc/firmware/yamato_pm4.fw

#Files needed for compiling against Acer's proprietary libcamera (currently not working, workaround avaible)
#   device/acer/liquid/proprietary/lib/liboemcamera.so:obj/lib/liboemcamera.so \
#   device/acer/liquid/proprietary/lib/libcamera.so:system/lib/libcamera.so \
#   device/acer/liquid/proprietary/lib/libcamera.so:obj/lib/libcamera.so \
#Copy camera libraries for building RE'd libcamera2
PRODUCT_COPY_FILES += \
   device/acer/liquid/proprietary/lib/liboemcamera.so:system/lib/liboemcamera.so \
   device/acer/liquid/proprietary/lib/liboemcamera.so:obj/lib/liboemcamera.so \
   device/acer/liquid/proprietary/lib/libmmipl.so:system/lib/libmmipl.so \
   device/acer/liquid/proprietary/lib/libmmipl.so:obj/lib/libmmipl.so \
   device/acer/liquid/proprietary/lib/libmmjpeg.so:system/lib/libmmjpeg.so \
   device/acer/liquid/proprietary/lib/libmmjpeg.so:obj/lib/libmmjpeg.so 

#Copy Gralloc, Copybit and libaudio from CodeAurora qsd8k/surf build
PRODUCT_COPY_FILES += \
   device/acer/liquid/proprietary/lib/hw/copybit.qsd8k.so:system/lib/hw/copybit.qsd8k.so \
   device/acer/liquid/proprietary/lib/hw/gralloc.qsd8k.so:system/lib/hw/gralloc.qsd8k.so \
   device/acer/liquid/proprietary/lib/libaudio.so:system/lib/libaudio.so

