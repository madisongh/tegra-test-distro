FILESEXTRAPATHS_prepend := "${THISDIR}/${BPN}:"

CBOOTFILES = "\
    file://0001-Add-support-for-custom-bootloader.patch \
    file://disable-uboot.cfg \
    file://enable-cboot.cfg \
    file://swupdate-bootloader-interface-cboot.sh \
"

CBOOTFILES_tegra210 = ""

SRC_URI_append_tegra = "\
    file://disable-mtd.cfg \
    file://disable-cfi.cfg \
    ${CBOOTFILES} \
"

install_cboot_interface() {
    install -d ${D}${sbindir}
    install -m 0755 ${WORKDIR}/swupdate-bootloader-interface-cboot.sh ${D}${sbindir}/swupdate-bootloader-interface
}
install_cboot_interface_tegra210() {
    :
}

do_install_append() {
    install_cboot_interface
}

FILES_${PN} += "${sbindir}/swupdate-bootloader-interface"
CBOOTTOOLS = "tegra-boot-tools"
CBOOTTOOLS_tegra210 = ""
RDEPENDS_${PN} += "${CBOOTTOOLS}"
PACKAGE_ARCH = "${MACHINE_ARCH}"
