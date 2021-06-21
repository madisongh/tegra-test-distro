FILESEXTRAPATHS_prepend := "${THISDIR}/${BPN}:"

SRC_URI_append_tegra = "\
    file://disable-mtd.cfg \
    file://disable-cfi.cfg \
"
SRC_URI_append_tegra186 = " file://disable-uboot.cfg"
SRC_URI_append_tegra194 = " file://disable-uboot.cfg"
