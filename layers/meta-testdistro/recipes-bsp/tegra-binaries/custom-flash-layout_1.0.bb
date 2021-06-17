DESCRIPTION = "Custom flash layout files"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

INHIBIT_DEFAULT_DEPS = "1"
COMPATIBLE_MACHINE = "(cryptparts|jetson-tx2|jetson-nano-qspi-sd-sb|jetson-nano-qspi-sd|jetson-nano-emmc|jetson-xavier|jetson-tx1)"

SRC_URI = "file://flash_${MACHINE}_custom.xml"

S = "${WORKDIR}"

do_install() {
    install -d ${D}${datadir}/custom-flash-layout
    install -m 0644 ${S}/flash_${MACHINE}_custom.xml ${D}${datadir}/custom-flash-layout/
}

PACKAGE_ARCH = "${MACHINE_ARCH}"

inherit nopackages
