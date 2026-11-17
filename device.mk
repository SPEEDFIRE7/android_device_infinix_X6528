# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

# APEX updates
$(call inherit-product, $(SRC_TARGET_DIR)/product/updatable_apex.mk)

# Virtual A/B
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota/launch_with_vendor_ramdisk.mk)
PRODUCT_VIRTUAL_AB_COMPRESSION := true

# API level
PRODUCT_SHIPPING_API_LEVEL := 33

# Dynamic partitions
PRODUCT_USE_DYNAMIC_PARTITIONS := true
PRODUCT_BUILD_CACHE_IMAGE := false

# Boot control HAL: use the stock Unisoc service only (see X6528 reference).
PRODUCT_PACKAGES += \
    android.hardware.boot@1.2-impl.recovery

# OTA / virtual A/B
PRODUCT_PACKAGES += \
    checkpoint_gc \
    otapreopt_script \
    snapuserd \
    snapuserd.recovery \
    snapuserd.vendor_ramdisk \
    update_engine \
    update_engine_sideload \
    update_verifier

AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=system/bin/otapreopt_script \
    FILESYSTEM_TYPE_system=erofs \
    POSTINSTALL_OPTIONAL_system=true

AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_vendor=true \
    POSTINSTALL_PATH_vendor=bin/checkpoint_gc \
    FILESYSTEM_TYPE_vendor=erofs \
    POSTINSTALL_OPTIONAL_vendor=true

# fastbootd
PRODUCT_PACKAGES += \
    android.hardware.fastboot@1.1-impl-mock \
    fastbootd

# Health HAL: the stock android.hardware.health-service.example is kept from
# the blob dump; do not also install AOSP's android.hardware.health@2.1-service.

# First/second-stage fstab and recovery rootdir files.
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rootdir/etc/fstab.X6528:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/first_stage_ramdisk/fstab.X6528 \
    $(LOCAL_PATH)/rootdir/etc/fstab.X6528:$(TARGET_COPY_OUT_RECOVERY)/root/first_stage_ramdisk/fstab.X6528 \
    $(LOCAL_PATH)/rootdir/etc/fstab.X6528:$(TARGET_COPY_OUT_VENDOR)/etc/fstab.X6528 \
    $(LOCAL_PATH)/rootdir/etc/modules.load:$(TARGET_COPY_OUT_RECOVERY)/root/lib/modules/modules.load \
    $(LOCAL_PATH)/rootdir/etc/init.recovery.X6528.rc:$(TARGET_COPY_OUT_RECOVERY)/root/init.recovery.X6528.rc \
    $(LOCAL_PATH)/rootdir/etc/ueventd.X6528.rc:$(TARGET_COPY_OUT_RECOVERY)/root/ueventd.X6528.rc \
    $(LOCAL_PATH)/rootdir/etc/ueventd.module.rc:$(TARGET_COPY_OUT_RECOVERY)/root/ueventd.module.rc \
    $(LOCAL_PATH)/rootdir/bin/load_modules.sh:$(TARGET_COPY_OUT_RECOVERY)/root/system/bin/load_modules.sh \
    $(LOCAL_PATH)/prebuilts/avb/q-gsi.avbpubkey:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/avb/q-gsi.avbpubkey \
    $(LOCAL_PATH)/prebuilts/avb/r-gsi.avbpubkey:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/avb/r-gsi.avbpubkey \
    $(LOCAL_PATH)/prebuilts/avb/s-gsi.avbpubkey:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/avb/s-gsi.avbpubkey \
    $(LOCAL_PATH)/prebuilts/avb/q-gsi.avbpubkey:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/first_stage_ramdisk/avb/q-gsi.avbpubkey \
    $(LOCAL_PATH)/prebuilts/avb/r-gsi.avbpubkey:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/first_stage_ramdisk/avb/r-gsi.avbpubkey \
    $(LOCAL_PATH)/prebuilts/avb/s-gsi.avbpubkey:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/first_stage_ramdisk/avb/s-gsi.avbpubkey \
    $(LOCAL_PATH)/prebuilts/avb/q-gsi.avbpubkey:$(TARGET_COPY_OUT_RECOVERY)/root/avb/q-gsi.avbpubkey \
    $(LOCAL_PATH)/prebuilts/avb/r-gsi.avbpubkey:$(TARGET_COPY_OUT_RECOVERY)/root/avb/r-gsi.avbpubkey \
    $(LOCAL_PATH)/prebuilts/avb/s-gsi.avbpubkey:$(TARGET_COPY_OUT_RECOVERY)/root/avb/s-gsi.avbpubkey

# Product overlays (RRO)
DEVICE_PACKAGE_OVERLAYS += $(LOCAL_PATH)/overlay
PRODUCT_PACKAGES += \
    BluetoothOverlayX6528 \
    TetheringOverlayX6528 \
    WifiOverlayX6528

# HALs / vendor services
PRODUCT_PACKAGES += \
    android.hardware.cas@1.2-service-lazy \
    android.hardware.hardware_keystore.xml \
    android.hardware.wifi@1.0-service-lazy \
    libwifi-hal \
    vndservice \
    vndservicemanager

# Product characteristics
PRODUCT_CHARACTERISTICS := default

# Prebuilt Unisoc kernel config does not satisfy FCM level 6 requirements.
PRODUCT_OTA_ENFORCE_VINTF_KERNEL_REQUIREMENTS := false

# Stock init scripts and helper binaries shipped by this device tree.
PRODUCT_PACKAGES += \
    log_to_csv.sh \
    loading.sh \
    para.sh \
    total.sh \
    create_splloader_dual_slot_byname_path.sh \
    init.insmod.sh

PRODUCT_PACKAGES += \
    init.X6528.rc \
    init.X6528.usb.rc \
    init.X6528B.rc \
    init.X6528B.usb.rc \
    init.ram.rc \
    init.ram.gms.rc \
    init.ram.native.rc \
    init.storage.rc \
    init.cali.rc

# Soong namespace for rootdir/Android.bp
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH)

# Inherit the proprietary files
$(call inherit-product, vendor/infinix/X6528/X6528-vendor.mk)
