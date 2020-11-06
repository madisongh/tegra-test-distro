DESCRIPTION = "Service configuration drop-in for docker"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

SRC_URI = "file://docker-storage-redirect.conf"

S = "${WORKDIR}"

do_install() {
    :
}

do_install_semi-stateless() {
    install -d ${D}${systemd_system_unitdir}/docker.service.d
    install -m 0644 ${S}/docker-storage-redirect.conf ${D}${systemd_system_unitdir}/docker.service.d/
}

ALLOW_EMPTY_${PN} = "1"
FILES_${PN} = "${systemd_system_unitdir}"

