FILESEXTRAPATHS_prepend := "${THISDIR}/${BPN}:"

SRC_URI += "file://networkd-wait-any.conf"
SRC_URI += "file://system-overrides.conf"
SRC_URI += "file://srv-cache-tmpfiles.conf"
SRC_URI_append_secureboot = " file://crypttab"
SRC_URI_append_secureboot = " file://dmcrypt-cleanup.service"
SRC_URI_append_secureboot = " file://prod-additions.fstab"
SRC_URI_append_secureboot = " file://fs-pre-workaround.conf"

inherit systemd

install_tmpfiles_config() {
    install -m 0644 ${WORKDIR}/srv-cache-tmpfiles.conf ${D}${sysconfdir}/tmpfiles.d/00-srv-cache.conf
}
install_tmpfiles_config_semi-stateless() {
    :
}

do_install_append() {
    install -d ${D}${sysconfdir}/systemd/system.conf.d
    install -m 0644 ${WORKDIR}/system-overrides.conf ${D}${sysconfdir}/systemd/system.conf.d/99-system-overrides.conf
    install -d ${D}${sysconfdir}/systemd/system/systemd-networkd-wait-online.service.d
    install -m 0644 ${WORKDIR}/networkd-wait-any.conf ${D}${sysconfdir}/systemd/system/systemd-networkd-wait-online.service.d/
    install -d ${D}${sysconfdir}/tmpfiles.d
    ln -sf /dev/null ${D}${sysconfdir}/tmpfiles.d/tmp.conf
    install_tmpfiles_config
}

# Must block systemd's automatic /tmp mountpoint when using
# the volatile rootfs overlay - it's not needed in that case anyway.
do_install_append_semi-stateless() {
    ln -sf /dev/null ${D}${sysconfdir}/systemd/system/tmp.mount
}

do_install_append_secureboot() {
    install -m 0644 ${WORKDIR}/crypttab ${D}${sysconfdir}/
    install -d ${D}${sysconfdir}/systemd/system
    install -m 0644 ${WORKDIR}/dmcrypt-cleanup.service ${D}${sysconfdir}/systemd/system/
    install -m 0644 ${WORKDIR}/prod-additions.fstab ${D}${sysconfdir}/
    install -d ${D}/data
    # XXX can remove this after updating to systemd v245 or later
    install -d ${D}${sysconfdir}/systemd/system/local-fs-pre-target.d
    install -m 0644 ${WORKDIR}/fs-pre-workaround.conf ${D}${sysconfdir}/systemd/system/local-fs-pre-target.d/
    # XXX
}

pkg_postinst_${PN}-prod() {
    cat $D${sysconfdir}/prod-additions.fstab >>$D${sysconfdir}/fstab
    rm -f $D${sysconfdir}/prod-additions.fstab
}

PACKAGES_prepend_secureboot = "${PN}-prod "
SYSTEMD_PACKAGES_append_secureboot = " ${PN}-prod"
SYSTEMD_SERVICE_${PN}-prod = "dmcrypt-cleanup.service"
FILES_${PN}-prod = "${sysconfdir}/prod-additions.fstab /data ${sysconfdir}/crypttab"
FILES_${PN} += "${sysconfdir}/systemd ${sysconfdir}/tmpfiles.d"
