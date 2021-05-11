FILESEXTRAPATHS_prepend := "${THISDIR}/linux-tegra:${COREBASE}/meta-rauc/recipes-kernel/linux/linux-yocto:"

SRC_URI += " \
    file://0001-nvidia-crypto-disable-sha256-algorithm-in-tegra-se-d.patch \
    file://rauc.cfg \
    file://verity.cfg \
"

