FILESEXTRAPATHS:prepend := "${THISDIR}/${BPN}:"

CBOOTFILES = "\
    file://0001-Add-support-for-custom-bootloader.patch \
    file://disable-uboot.cfg \
    file://enable-cboot.cfg \
    file://swupdate-bootloader-interface-cboot.sh \
"

SRC_URI:append:tegra = "\
    file://disable-mtd.cfg \
    file://disable-cfi.cfg \
    ${CBOOTFILES} \
"

install_cboot_interface() {
    install -d ${D}${sbindir}
    install -m 0755 ${WORKDIR}/swupdate-bootloader-interface-cboot.sh ${D}${sbindir}/swupdate-bootloader-interface
}

do_install:append() {
    install_cboot_interface
}

FILES:${PN} += "${sbindir}/swupdate-bootloader-interface"
CBOOTTOOLS = "tegra-boot-tools"
RDEPENDS:${PN} += "${CBOOTTOOLS}"
PACKAGE_ARCH = "${MACHINE_ARCH}"
