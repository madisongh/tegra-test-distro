DESCRIPTION = "Generic systemd-based initrd setup"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/COPYING.MIT;md5=3da9cfbcb788c80a0384361b4de20420"

SRC_URI = "\
    file://initrd-system-overrides.conf \
"

S = "${WORKDIR}"
B = "${WORKDIR}/build"

inherit systemd

do_install() {
    install -d ${D}${sysconfdir}/systemd/system
    touch ${D}${sysconfdir}/initrd-release
    install -d ${D}${sysconfdir}/systemd/system.conf.d
    install -m 0644 ${S}/initrd-system-overrides.conf ${D}${sysconfdir}/systemd/system.conf.d/
    install -d ${D}/sysroot
}

FILES:${PN} += "/sysroot"
RDEPENDS:${PN} = "systemd"
