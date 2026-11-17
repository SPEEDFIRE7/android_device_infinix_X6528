# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit from the Infinix X6528 device tree.
$(call inherit-product, device/infinix/X6528/device.mk)

# Inherit some common Lineage stuff.
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

PRODUCT_DEVICE := X6528
PRODUCT_NAME := lineage_X6528
PRODUCT_BRAND := Infinix
PRODUCT_MODEL := Infinix X6528
PRODUCT_MANUFACTURER := Infinix

PRODUCT_GMS_CLIENTID_BASE := android-transsion

# Stock build fingerprint from the X6528 reference dump.
PRODUCT_BUILD_PROP_OVERRIDES += \
    PRIVATE_BUILD_DESC="X6528-user 13 TP1A.220624.014 585 release-keys" \
    BUILD_FINGERPRINT="Infinix/X6528-OP/X6528:13/TP1A.220624.014/250917V1996:user/release-keys"
