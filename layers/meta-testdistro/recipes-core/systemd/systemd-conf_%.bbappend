FILESEXTRAPATHS:prepend := "${THISDIR}/${BPN}:"

SRC_URI += "file://networkd-wait-any.conf"
SRC_URI += "file://system-overrides.conf"
SRC_URI += "file://srv-cache-tmpfiles.conf"
SRC_URI += "file://var-log-journal.conf"
SRC_URI += "file://locale.conf"
SRC_URI:append:cryptparts = " file://crypttab"
SRC_URI:append:cryptparts = " file://dmcrypt-cleanup.service"
SRC_URI:append:cryptparts = " file://prod-additions.fstab"

inherit systemd

install_tmpfiles_config() {
    install -m 0644 ${WORKDIR}/srv-cache-tmpfiles.conf ${D}${sysconfdir}/tmpfiles.d/00-srv-cache.conf
}
install_tmpfiles_config:semi-stateless() {
    :
}

do_install:append() {
    install -d ${D}${sysconfdir}/systemd/system.conf.d
    install -m 0644 ${WORKDIR}/system-overrides.conf ${D}${sysconfdir}/systemd/system.conf.d/99-system-overrides.conf
    install -d ${D}${sysconfdir}/systemd/system/systemd-networkd-wait-online.service.d
    install -m 0644 ${WORKDIR}/networkd-wait-any.conf ${D}${sysconfdir}/systemd/system/systemd-networkd-wait-online.service.d/
    install -d ${D}${sysconfdir}/tmpfiles.d
    ln -sf /dev/null ${D}${sysconfdir}/tmpfiles.d/tmp.conf
    install -m 0644 ${WORKDIR}/var-log-journal.conf ${D}${sysconfdir}/tmpfiles.d/00-var-log-journal.conf
    install_tmpfiles_config
    # OE-Core installs this to forward to syslog, which we're not using
    rm -rf ${D}${systemd_unitdir}/journald.conf.d
    install -m 0644 ${WORKDIR}/locale.conf ${D}${sysconfdir}/
}

# Must block systemd's automatic /tmp mountpoint when using
# the volatile rootfs overlay - it's not needed in that case anyway.
do_install:append:semi-stateless() {
    ln -sf /dev/null ${D}${sysconfdir}/systemd/system/tmp.mount
}

do_install:append:cryptparts() {
    install -m 0644 ${WORKDIR}/crypttab ${D}${sysconfdir}/
    install -d ${D}${sysconfdir}/systemd/system
    install -m 0644 ${WORKDIR}/dmcrypt-cleanup.service ${D}${sysconfdir}/systemd/system/
    install -m 0644 ${WORKDIR}/prod-additions.fstab ${D}${sysconfdir}/
    install -d ${D}/data
}

pkg_postinst:${PN}-prod() {
    cat $D${sysconfdir}/prod-additions.fstab >>$D${sysconfdir}/fstab
    rm -f $D${sysconfdir}/prod-additions.fstab
}

PACKAGES:prepend:cryptparts = "${PN}-prod ${PN}-crypttab "
SYSTEMD_PACKAGES:append:cryptparts = " ${PN}-prod"
SYSTEMD_SERVICE:${PN}-prod = "dmcrypt-cleanup.service"
FILES:${PN}-prod = "${sysconfdir}/prod-additions.fstab /data"
FILES:${PN}-crypttab = "${sysconfdir}/crypttab"
FILES:${PN} += "${sysconfdir}/systemd ${sysconfdir}/tmpfiles.d ${sysconfdir}/locale.conf"
