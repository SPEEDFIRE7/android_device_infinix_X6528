# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#
# Infinix Hot 40i (X6528 / X6528B), Unisoc T606 / UMS9230 / qogirl6.
# Structure follows the Smart 8 (X6528) lineage-20 reference tree.

DEVICE_PATH := device/infinix/X6528

# Architecture
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 :=
TARGET_CPU_VARIANT := generic
TARGET_CPU_VARIANT_RUNTIME := cortex-a75

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv7-a-neon
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := generic
TARGET_2ND_CPU_VARIANT_RUNTIME := cortex-a55

# Platform
TARGET_BOARD_PLATFORM := ums9230
TARGET_BOOTLOADER_BOARD_NAME := X6528
TARGET_NO_BOOTLOADER := true
TARGET_OTA_ASSERT_DEVICE := X6528,X6528B,X6528

# Treble / VNDK / API levels
BOARD_VNDK_VERSION := current
BOARD_SHIPPING_API_LEVEL := 33
BOARD_API_LEVEL := 33
VENDOR_SECURITY_PATCH := 2024-05-05

# Display
TARGET_SCREEN_DENSITY := 320

# A/B and virtual A/B
AB_OTA_UPDATER := true

AB_OTA_PARTITIONS += \
    boot \
    dtbo \
    odm \
    product \
    system \
    system_ext \
    vbmeta \
    vbmeta_system \
    vbmeta_vendor \
    vendor \
    vendor_boot \
    vendor_dlkm

# Boot image / GKI
BOARD_BOOT_HEADER_VERSION := 4
BOARD_KERNEL_BASE := 0x00000000
BOARD_KERNEL_PAGESIZE := 4096
BOARD_KERNEL_OFFSET := 0x00008000
BOARD_RAMDISK_OFFSET := 0x05400000
BOARD_KERNEL_TAGS_OFFSET := 0x00000100
BOARD_KERNEL_CMDLINE := console=ttyS1,115200n8 buildvariant=user androidboot.selinux=permissive enforcing=0
BOARD_KERNEL_IMAGE_NAME := Image
BOARD_RAMDISK_USE_LZ4 := true
BOARD_MKBOOTIMG_ARGS += \
    --header_version $(BOARD_BOOT_HEADER_VERSION) \
    --ramdisk_offset $(BOARD_RAMDISK_OFFSET) \
    --tags_offset $(BOARD_KERNEL_TAGS_OFFSET)

BOARD_USES_GENERIC_KERNEL_IMAGE := true
BOARD_MOVE_RECOVERY_RESOURCES_TO_VENDOR_BOOT := true
BOARD_INCLUDE_RECOVERY_RAMDISK_IN_VENDOR_BOOT := true
BOARD_MOVE_GSI_AVB_KEYS_TO_VENDOR_BOOT := true

# Kernel (prebuilt from the X6528 device tree)
TARGET_FORCE_PREBUILT_KERNEL := true
ifeq ($(TARGET_FORCE_PREBUILT_KERNEL),true)
TARGET_PREBUILT_KERNEL := $(DEVICE_PATH)/prebuilts/kernel
TARGET_PREBUILT_DTB := $(DEVICE_PATH)/prebuilts/dtb.img
BOARD_MKBOOTIMG_ARGS += --dtb $(TARGET_PREBUILT_DTB)
BOARD_PREBUILT_DTBOIMAGE := $(DEVICE_PATH)/prebuilts/dtbo.img
else
TARGET_KERNEL_SOURCE := kernel/infinix/X6528
TARGET_KERNEL_CONFIG := X6528_defconfig
TARGET_KERNEL_CLANG_COMPILE := true
BOARD_KERNEL_SEPARATED_DTBO := true
endif

# Partitions
BOARD_FLASH_BLOCK_SIZE := 262144  # BOARD_KERNEL_PAGESIZE * 64
BOARD_BOOTIMAGE_PARTITION_SIZE := 67108864
BOARD_DTBOIMG_PARTITION_SIZE := 8388608
BOARD_VENDOR_BOOTIMAGE_PARTITION_SIZE := 104857600

# Values carried over from the X6528 reference tree. Verify with
# `adb shell lpdump /dev/block/by-name/super` and adjust before release.
BOARD_SUPER_PARTITION_SIZE := 9126805504
BOARD_SUPER_PARTITION_GROUPS := infinix_dynamic_partitions
BOARD_INFINIX_DYNAMIC_PARTITIONS_PARTITION_LIST := \
    system \
    system_ext \
    vendor \
    product \
    odm \
    vendor_dlkm
BOARD_INFINIX_DYNAMIC_PARTITIONS_SIZE := 9122611200

# Filesystems
TARGET_USES_EROFS := true
BOARD_SYSTEMIMAGE_FILE_SYSTEM_TYPE := erofs
BOARD_SYSTEM_EXTIMAGE_FILE_SYSTEM_TYPE := erofs
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := erofs
BOARD_PRODUCTIMAGE_FILE_SYSTEM_TYPE := erofs
BOARD_ODMIMAGE_FILE_SYSTEM_TYPE := erofs
BOARD_VENDOR_DLKMIMAGE_FILE_SYSTEM_TYPE := erofs
BOARD_EROFS_COMPRESSOR := lz4

TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true
BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := f2fs
PRODUCT_FS_COMPRESSION := 1

TARGET_COPY_OUT_VENDOR := vendor
TARGET_COPY_OUT_PRODUCT := product
TARGET_COPY_OUT_SYSTEM_EXT := system_ext
TARGET_COPY_OUT_ODM := odm
TARGET_COPY_OUT_VENDOR_DLKM := vendor_dlkm
BOARD_USES_METADATA_PARTITION := true
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_ROOT_EXTRA_FOLDERS += tranfs blackbox

# Recovery
TARGET_RECOVERY_FSTAB := $(DEVICE_PATH)/rootdir/etc/fstab.X6528
TARGET_RECOVERY_PIXEL_FORMAT := RGBX_8888
BOARD_DO_NOT_STRIP_VENDOR_RAMDISK_MODULES := true
BOARD_VENDOR_RAMDISK_KERNEL_MODULES := $(wildcard $(DEVICE_PATH)/prebuilts/modules/*.ko)
BOARD_VENDOR_RAMDISK_KERNEL_MODULES_LOAD := $(strip $(shell cat $(DEVICE_PATH)/rootdir/etc/modules.load))
BOARD_VENDOR_RAMDISK_RECOVERY_KERNEL_MODULES_LOAD := $(strip $(shell cat $(DEVICE_PATH)/rootdir/etc/modules.load.recovery))
BOARD_DO_NOT_STRIP_RECOVERY_MODULES := true
BOARD_RECOVERY_KERNEL_MODULES := $(BOARD_VENDOR_RAMDISK_KERNEL_MODULES)
BOARD_RECOVERY_KERNEL_MODULES_LOAD := $(BOARD_VENDOR_RAMDISK_RECOVERY_KERNEL_MODULES_LOAD)

# Verified boot
BOARD_AVB_ENABLE := true
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --flags 3
BOARD_AVB_MAKE_VBMETA_SYSTEM_IMAGE_ARGS += --flags 3
BOARD_AVB_MAKE_VBMETA_VENDOR_IMAGE_ARGS += --flags 3
BOARD_AVB_VBMETA_SYSTEM := system system_ext product
BOARD_AVB_VBMETA_VENDOR := vendor odm vendor_dlkm
BOARD_AVB_VBMETA_SYSTEM_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_VBMETA_VENDOR_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_VBMETA_SYSTEM_ALGORITHM := SHA256_RSA4096
BOARD_AVB_VBMETA_VENDOR_ALGORITHM := SHA256_RSA4096
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX := $(PLATFORM_SECURITY_PATCH_TIMESTAMP)
BOARD_AVB_VBMETA_VENDOR_ROLLBACK_INDEX := $(PLATFORM_SECURITY_PATCH_TIMESTAMP)
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX_LOCATION := 1
BOARD_AVB_VBMETA_VENDOR_ROLLBACK_INDEX_LOCATION := 2

# Properties
TARGET_SYSTEM_PROP += $(DEVICE_PATH)/system.prop
TARGET_VENDOR_PROP += $(DEVICE_PATH)/vendor.prop
TARGET_PRODUCT_PROP += $(DEVICE_PATH)/product.prop
TARGET_SYSTEM_EXT_PROP += $(DEVICE_PATH)/system_ext.prop
TARGET_SYSTEM_DLKM_PROP += $(DEVICE_PATH)/system_dlkm.prop
TARGET_ODM_PROP += $(DEVICE_PATH)/odm.prop
TARGET_ODM_DLKM_PROP += $(DEVICE_PATH)/odm_dlkm.prop
TARGET_VENDOR_DLKM_PROP += $(DEVICE_PATH)/vendor_dlkm.prop

# Wi-Fi
WIFI_MULTIPLE_VENDOR_HALS := true
WIFI_AVOID_IFACE_RESET_MAC_CHANGE := true

# VINTF
DEVICE_MANIFEST_FILE += \
    $(DEVICE_PATH)/manifest.xml \
    vendor/infinix/X6528/proprietary/vendor/etc/vintf/manifest/android.hardware.biometrics.fingerprint@2.1-service.xml \
    vendor/infinix/X6528/proprietary/vendor/etc/vintf/manifest/android.hardware.drm-service.clearkey.xml \
    vendor/infinix/X6528/proprietary/vendor/etc/vintf/manifest/android.hardware.gatekeeper@1.0-service.trusty.xml \
    vendor/infinix/X6528/proprietary/vendor/etc/vintf/manifest/android.hardware.health-service.example.xml \
    vendor/infinix/X6528/proprietary/vendor/etc/vintf/manifest/android.hardware.sensors-multihal.xml \
    vendor/infinix/X6528/proprietary/vendor/etc/vintf/manifest/android.hardware.usb-service.example.xml \
    vendor/infinix/X6528/proprietary/vendor/etc/vintf/manifest/android.hardware.wifi.hostapd.xml \
    vendor/infinix/X6528/proprietary/vendor/etc/vintf/manifest/android.hardware.wifi.supplicant.xml \
    vendor/infinix/X6528/proprietary/vendor/etc/vintf/manifest/bluetooth_audio.xml \
    vendor/infinix/X6528/proprietary/vendor/etc/vintf/manifest/face-default.xml \
    vendor/infinix/X6528/proprietary/vendor/etc/vintf/manifest/power.stats-default.xml
DEVICE_MATRIX_FILE += $(DEVICE_PATH)/compatibility_matrix.xml
DEVICE_FRAMEWORK_COMPATIBILITY_MATRIX_FILE += $(DEVICE_PATH)/framework_compatibility_matrix.xml
ODM_MANIFEST_FILES += $(DEVICE_PATH)/odm_manifest.xml

# SELinux / bring-up
SELINUX_IGNORE_NEVERALLOWS := true
BUILD_BROKEN_ELF_PREBUILT_PRODUCT_COPY_FILES := true

# Vendor
include vendor/infinix/X6528/BoardConfigVendor.mk
