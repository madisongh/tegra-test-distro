FILESEXTRAPATHS:prepend := "${THISDIR}/${BPN}:"

SRC_URI += "\
    file://rauc-hawkbit-updater.conf.in \
    file://rauc-hawkbit-updater-dropin.conf \
    file://rauc-hawkbit-updater-setup.sh \
"

do_install:append() {
    rm -f ${D}${sysconfdir}/${PN}/config.conf
    ln -s /run/rauc-hawkbit-updater/config.conf ${D}${sysconfdir}/${PN}/config.conf
    sed -e's,@MACHINE@,${MACHINE},' ${WORKDIR}/rauc-hawkbit-updater.conf.in >${D}${sysconfdir}/${PN}/config.conf.template
    chmod 0644 ${D}${sysconfdir}/${PN}/config.conf.template
    install -d ${D}${sysconfdir}/systemd/system/rauc-hawkbit-updater.service.d
    install -m 0644 ${WORKDIR}/rauc-hawkbit-updater-dropin.conf ${D}${sysconfdir}/systemd/system/rauc-hawkbit-updater.service.d/
    install -d ${D}${sysconfdir}/${PN}/scripts
    install -m 0755 ${WORKDIR}/rauc-hawkbit-updater-setup.sh ${D}${sysconfdir}/${PN}/scripts/setup-config
}
