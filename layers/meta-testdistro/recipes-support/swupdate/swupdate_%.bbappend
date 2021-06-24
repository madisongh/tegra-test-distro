FILESEXTRAPATHS_prepend := "${THISDIR}/${BPN}:"

PACKAGECONFIG ??= ""
PACKAGECONFIG[hawkbit] = ",,,,,"

SRC_URI += "\
    file://systemd.cfg \
    file://rdiff.cfg \
    file://hash.cfg \
    file://archive.cfg \
    file://part-format.cfg \
    file://get-slot.sh \
    file://disable_http_server.cfg \
"

HAWKBIT_STUFF = "\
    file://suricatta_hawkbit.cfg \
    file://hawkbit-server.sh \
"

SRC_URI_append_secureboot = "\
    file://keyargs.sh \
    file://swupdate.pem \
    file://signed-images.cfg \
    ${@bb.utils.contains('PACKAGECONFIG', 'hawkbit', '${HAWKBIT_STUFF}', '', d)} \
"


do_install_append() {
    install -d ${D}${sysconfdir}/swupdate/conf.d
    install -m 0644 ${WORKDIR}/get-slot.sh ${D}${sysconfdir}/swupdate/conf.d/00-tegra-boot-slot
    sed -i -r -e'/^Type=/d' -e'/\[Service/a Type=notify' \
              -e'/^Environment=TMPDIR/d' -e'/\[Service/a Environment=TMPDIR=/run/swupdate/tmp' \
              -e'/^ExecStartPre=.bin.mkdir/d' -e'/\[Service/a ExecStartPre=/bin/mkdir -p /run/swupdate/tmp' ${D}${systemd_system_unitdir}/swupdate.service
}

do_install_append_secureboot() {
    install -m 0644 ${WORKDIR}/swupdate.pem ${D}${sysconfdir}/swupdate/
    install -m 0644 ${WORKDIR}/keyargs.sh ${D}${sysconfdir}/swupdate/conf.d/10-key-args
    if ${@bb.utils.contains('PACKAGECONFIG', 'hawkbit', 'true', 'false', d)}; then
        install -m 0644 ${WORKDIR}/hawkbit-server.sh ${D}${sysconfdir}/swupdate/conf.d/20-hawkbit
    fi
}

RDEPENDS_${PN} += "tegra-boot-tools swupdate-machine-config"

PACKAGE_ARCH = "${MACHINE_ARCH}"
