DESCRIPTION = "Machine-specific configuration for swupdate"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

SWUPDATE_BOARDNAME ??= "${MACHINE}"
SWUPDATE_HWREVISION ??= "1.0"

do_compile() {
    rm -f ${B}/hwrevision
    echo "${SWUPDATE_BOARDNAME} ${SWUPDATE_HWREVISION}" > ${B}/hwrevision
}

do_install() {
    install -d ${D}${sysconfdir}
    install -m 0644 ${B}/hwrevision ${D}${sysconfdir}/
}

PACKAGE_ARCH = "${MACHINE_ARCH}"
