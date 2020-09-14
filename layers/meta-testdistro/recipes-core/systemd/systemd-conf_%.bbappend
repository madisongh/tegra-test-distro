FILESEXTRAPATHS_prepend := "${THISDIR}/${BPN}:"

SRC_URI += "file://networkd-wait-any.conf"
SRC_URI += "file://system-overrides.conf"
SRC_URI_append_secureboot = " file://crypttab"
SRC_URI_append_secureboot = " file://dmcrypt-cleanup.service"
SRC_URI_append_secureboot = " file://prod-additions.fstab"

inherit systemd

do_install_append() {
    install -d ${D}${sysconfdir}/systemd/system/systemd-networkd-wait-online.service.d
    install -m 0644 ${WORKDIR}/networkd-wait-any.conf ${D}${sysconfdir}/systemd/system/systemd-networkd-wait-online.service.d/
}

do_install_append_secureboot() {
    install -d ${D}${sysconfdir}/systemd/system.conf.d
    install -m 0644 ${WORKDIR}/system-overrides.conf ${D}${sysconfdir}/systemd/system.conf.d/99-system-overrides.conf
    install -m 0644 ${WORKDIR}/crypttab ${D}${sysconfdir}/
    install -d ${D}${sysconfdir}/systemd/system
    install -m 0644 ${WORKDIR}/dmcrypt-cleanup.service ${D}${sysconfdir}/systemd/system/
    install -m 0644 ${WORKDIR}/prod-additions.fstab ${D}${sysconfdir}/
    install -d ${D}/data
}

pkg_postinst_${PN}-prod() {
    cat $D${sysconfdir}/prod-additions.fstab >>$D${sysconfdir}/fstab
    rm -f $D${sysconfdir}/prod-additions.fstab
}

PACKAGES_prepend_secureboot = "${PN}-prod "
SYSTEMD_PACKAGES_append_secureboot = " ${PN}-prod"
SYSTEMD_SERVICE_${PN}-prod = "dmcrypt-cleanup.service"
FILES_${PN}-prod = "${sysconfdir}/prod-additions.fstab /data ${sysconfdir}/crypttab"
FILES_${PN} += "${sysconfdir}/systemd"
