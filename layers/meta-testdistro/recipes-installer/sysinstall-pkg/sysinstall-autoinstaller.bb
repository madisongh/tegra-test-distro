DESCRIPTION = "Auto installer service"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

SRC_URI = "\
    file://autoinstall.service.in \
    file://autoinstall.sh.in \
"

S = "${WORKDIR}"
B = "${WORKDIR}/build"

inherit systemd

do_configure[noexec] = "1"

do_compile() {
    sed -e's,@BINDIR@,${bindir},g' ${S}/autoinstall.service.in > ${B}/autoinstall.service
    sed -e's,@SBINDIR@,${sbindir},g' ${S}/autoinstall.sh.in > ${B}/autoinstall
}

do_install() {
    install -d ${D}${systemd_system_unitdir}
    install -m 0644 ${B}/autoinstall.service ${D}${systemd_system_unitdir}/
    install -d ${D}${bindir}
    install -m 0755 ${B}/autoinstall ${D}${bindir}/
}

SYSTEMD_SERVICE_${PN} = "autoinstall.service"


