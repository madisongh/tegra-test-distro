DESCRIPTION = "Other boot-related files"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

INHIBIT_DEFAULT_DEPS = "1"
COMPATIBLE_MACHINE = "(tegra)"

SRC_URI = ""
SRC_URI_append_tegra194 = " file://cbo.dts"
SRC_URI_append_cryptparts = " file://eks.img"

S = "${WORKDIR}"

do_configure() {
    :
}

do_compile() {
    :
}

do_install() {
    :
}

do_install_tegra194() {
    install -d ${D}${datadir}/bootfiles
    install -m 0644 ${S}/cbo.dts ${D}${datadir}/bootfiles/
}

do_install_append_cryptparts() {
    install -d ${D}${datadir}/bootfiles
    install -m 0644 ${S}/eks.img ${D}${datadir}/bootfiles/
}

PACKAGE_ARCH = "${MACHINE_ARCH}"

inherit nopackages
