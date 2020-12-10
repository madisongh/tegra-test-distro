FILESEXTRAPATHS_prepend := "${THISDIR}/patches:"
SRC_URI_append_mender-uboot = " file://0014-mach-tegra-cboot.c-set-mender_boot_part-based-on-boo.patch"
