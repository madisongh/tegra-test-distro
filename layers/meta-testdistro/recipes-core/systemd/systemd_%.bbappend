PACKAGECONFIG:append = " cryptsetup"
EXTRA_OEMESON:append = " -Dwheel-group=false"

do_install:append() {
    rm -f ${D}${sysconfdir}/tmpfiles.d/00-create-volatile.conf
}
