#
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

LOCAL_PATH := $(call my-dir)

ifeq ($(TARGET_DEVICE),X6528)

# Symlinks present in stock /vendor and /odm images
$(call symlink-file,,../egl/libGLES_mali.so,$(TARGET_OUT_VENDOR)/lib/hw/vulkan.ums9230.so)
$(call symlink-file,,../egl/libGLES_mali.so,$(TARGET_OUT_VENDOR)/lib64/hw/vulkan.ums9230.so)
$(call symlink-file,,libOpenCL.so.1.2,$(TARGET_OUT_VENDOR)/lib/libOpenCL.so)
$(call symlink-file,,libOpenCL.so.1.2,$(TARGET_OUT_VENDOR)/lib/libOpenCL.so.1)
$(call symlink-file,,libOpenCL.so.1.2,$(TARGET_OUT_VENDOR)/lib/libOpenCL.so.1.1)
$(call symlink-file,,libGLES_mali_cl.so,$(TARGET_OUT_VENDOR)/lib/libOpenCL.so.1.2)
$(call symlink-file,,libOpenCL.so.1.2,$(TARGET_OUT_VENDOR)/lib64/libOpenCL.so)
$(call symlink-file,,libOpenCL.so.1.2,$(TARGET_OUT_VENDOR)/lib64/libOpenCL.so.1)
$(call symlink-file,,libOpenCL.so.1.2,$(TARGET_OUT_VENDOR)/lib64/libOpenCL.so.1.1)
$(call symlink-file,,libGLES_mali_cl.so,$(TARGET_OUT_VENDOR)/lib64/libOpenCL.so.1.2)
$(call symlink-file,,/vendor/lib/libnpi_rtc.so,$(TARGET_OUT_VENDOR)/lib/npidevice/libnpi_rtc.so)
$(call symlink-file,,/vendor/lib/libsensornpi.so,$(TARGET_OUT_VENDOR)/lib/npidevice/libsensornpi.so)
$(call symlink-file,,/odm/lib/libcamcalitest.so,$(TARGET_OUT_ODM)/lib/npidevice/libcamcalitest.so)

ALL_DEFAULT_INSTALLED_MODULES += \
    $(TARGET_OUT_VENDOR)/lib/hw/vulkan.ums9230.so \
    $(TARGET_OUT_VENDOR)/lib64/hw/vulkan.ums9230.so \
    $(TARGET_OUT_VENDOR)/lib/libOpenCL.so \
    $(TARGET_OUT_VENDOR)/lib/libOpenCL.so.1 \
    $(TARGET_OUT_VENDOR)/lib/libOpenCL.so.1.1 \
    $(TARGET_OUT_VENDOR)/lib/libOpenCL.so.1.2 \
    $(TARGET_OUT_VENDOR)/lib64/libOpenCL.so \
    $(TARGET_OUT_VENDOR)/lib64/libOpenCL.so.1 \
    $(TARGET_OUT_VENDOR)/lib64/libOpenCL.so.1.1 \
    $(TARGET_OUT_VENDOR)/lib64/libOpenCL.so.1.2 \
    $(TARGET_OUT_VENDOR)/lib/npidevice/libnpi_rtc.so \
    $(TARGET_OUT_VENDOR)/lib/npidevice/libsensornpi.so \
    $(TARGET_OUT_ODM)/lib/npidevice/libcamcalitest.so

endif
