DESCRIPTION = "Other boot-related files"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

INHIBIT_DEFAULT_DEPS = "1"
COMPATIBLE_MACHINE = "(jetson-tx2-sb)"

SRC_URI = "file://eks.img"

S = "${WORKDIR}"

do_install() {
    install -d ${D}${datadir}/bootfiles
    install -m 0644 ${S}/eks.img ${D}${datadir}/bootfiles/
}

PACKAGE_ARCH = "${MACHINE_ARCH}"

inherit nopackages
