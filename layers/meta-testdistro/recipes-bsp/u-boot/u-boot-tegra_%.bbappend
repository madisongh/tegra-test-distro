FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:${COREBASE}/meta-tegra-support/dynamic-layers/meta-rauc/recipes-bsp/u-boot/files:"

SRC_URI += "file://rauc.cfg"
