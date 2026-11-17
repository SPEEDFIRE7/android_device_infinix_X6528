# Android device tree for Infinix Hot 40i (X6528)

LineageOS 20 (Android 13) device tree for the Infinix Hot 40i X6528 / X6528B
(Unisoc T606 / UMS9230 / qogirl6). Same structure as the Smart 8 (X6525)
reference tree(thanks for @Seuj09) .

Build target:

```
lineage_X6528-userdebug
```

## Layout

```
device/infinix/X6528   <- this repository
vendor/infinix/X6528   <- generated vendor makefiles (separate zip)
```

The vendor makefiles are generated from `proprietary-files.txt`. The blobs
themselves are **not** redistributed here; However, you can view a ready-made version from here:
https://github.com/SPEEDFIRE7/android_vendor_infinix_X6528/releases/tag/vendor-blobs
or extract them from your own dump.

## Setup

From the root of a LineageOS 20 source tree:

```bash
git clone <device-tree-url> -b lineage-20 device/infinix/X6528
git clone <vendor-tree-url> -b lineage-20 vendor/infinix/X6528

# Dump layout: system/ system_ext/ product/ vendor/ odm/ vendor_dlkm/ ...
device/infinix/X6528/extract-files.sh /path/to/x6528-dump

source build/envsetup.sh
lunch lineage_X6528-userdebug
mka bacon
```

`extract-files.sh` uses LineageOS `extract_utils.sh` with the included
`proprietary-files.txt` and writes to `vendor/infinix/X6528/proprietary/`.
The supplied `infinix_X6528_vendor_blobs.zip` already contains that exact
layout, so it can be unpacked at the root of the source tree instead.

## Notes

- Dynamic partitions: `system system_ext vendor product odm vendor_dlkm`.
- A/B with virtual A/B; GKI kernel in `boot`, DTB + vendor ramdisk in
  `vendor_boot`, separate `dtbo`.
- Prebuilt kernel, `dtb.img` and `dtbo.img` are included under `prebuilts/`.
- The stock Unisoc boot/health HALs are intentionally kept from the blobs.
- Verify `BOARD_SUPER_PARTITION_SIZE` against `lpdump` on your device.
- Blob licensing: proprietary to Infinix/Transsion/Unisoc. Use only on
  hardware you own.
