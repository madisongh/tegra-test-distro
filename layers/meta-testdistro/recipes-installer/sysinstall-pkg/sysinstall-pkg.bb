DESCRIPTION = "Package a rootfs image for the installer"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

SRC_URI = "file://autoinstall.service.in"

S = "${WORKDIR}"
B = "${WORKDIR}/build"

SYSINSTALL_PKG_IMAGE ??= "demo-image-egl"

do_configure[noexec] = "1"

inherit systemd

do_compile() {
    sed -e 's,@SBINDIR@,${sbindir},' \
        ${S}/autoinstall.service.in > ${B}/autoinstall.service
}

do_install() {
    install -d ${D}/installer
    install -m 0644 ${DEPLOY_DIR_IMAGE}/${SYSINSTALL_PKG_IMAGE}-${MACHINE}.tar.gz ${D}/installer/image.tar.gz
    install -d ${D}${systemd_system_unitdir}
    install -m 0644 ${B}/autoinstall.service ${D}${systemd_system_unitdir}/
}
do_install[depends] += "${SYSINSTALL_PKG_IMAGE}:do_image_complete"

FILES_${PN} = "/installer"

SYSTEMD_SERVICE_${PN} = "autoinstall.service"
PACKAGE_ARCH = "${MACHINE_ARCH}"

