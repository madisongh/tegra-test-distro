FILESEXTRAPATHS_prepend := "${THISDIR}/${BPN}:"

SRC_URI += "\
    file://systemd.cfg \
    file://rdiff.cfg \
    file://hash.cfg \
    file://archive.cfg \
    file://part-format.cfg \
"
