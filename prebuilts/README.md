# prebuilts

Populate this directory from the images that match the `super` you dumped:

```
prebuilts/
  kernel          Image extracted from boot.img (unpack_bootimg output "kernel")
  dtb/dtb.dtb     DTB blob extracted from vendor_boot.img (output "dtb")
  dtbo.img        stock dtbo partition image (copied as-is)
```

`BoardConfig.mk` consumes them via:

```make
TARGET_PREBUILT_KERNEL := $(DEVICE_PATH)/prebuilts/kernel
BOARD_PREBUILT_DTBIMAGE_DIR := $(DEVICE_PATH)/prebuilts/dtb
BOARD_PREBUILT_DTBOIMAGE := $(DEVICE_PATH)/prebuilts/dtbo.img
```

`BOARD_PREBUILT_DTBIMAGE_DIR` must contain one or more `*.dtb` files; the build
concatenates them into `dtb.img`. The stock `vendor_boot.img` already contains a
single concatenated FDT blob, so one file named `dtb.dtb` is correct.

Do not commit these binaries to a public repo unless you are sure you have the
right to redistribute them; most people keep them out of git and regenerate them
from their own device.
