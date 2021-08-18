FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:${COREBASE}/meta-tegra-support/dynamic-layers/meta-rauc/recipes-bsp/u-boot/files:"

SRC_URI += "file://0001-Move-kernel-and-ramdisk-locations-on-t210-platforms.patch"
