PACKAGECONFIG_append = " cryptsetup"
EXTRA_OEMESON_append = " -Dwheel-group=false"

do_install_append() {
    rm -f ${D}${sysconfdir}/tmpfiles.d/00-create-volatile.conf
}
