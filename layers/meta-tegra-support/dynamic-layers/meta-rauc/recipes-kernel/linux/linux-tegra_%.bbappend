FILESEXTRAPATHS_prepend := "${THISDIR}/linux-tegra:${COREBASE}/meta-rauc/recipes-kernel/linux/linux-yocto:"

SRC_URI += "file://rauc.cfg"
SRC_URI += "file://verity.cfg"
