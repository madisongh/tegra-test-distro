FILESEXTRAPATHS:prepend := "${THISDIR}/${BPN}:"

PACKAGECONFIG ??= ""
PACKAGECONFIG[hawkbit] = ",,,,,"

SRC_URI += "\
    file://systemd.cfg \
    file://hash.cfg \
    file://disable_http_server.cfg \
    file://enable_delta.cfg \
    file://suricatta_general.cfg \
    file://signed-images.cfg \
"

DEPENDS += "zchunk"

do_install:append() {
    rm -rf ${D}${libdir}/swupdate
}

RDEPENDS:${PN} += "swupdate-machine-config"
