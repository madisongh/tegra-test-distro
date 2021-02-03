EXTRADEPS = "bootfiles"
EXTRADEPS_append_cryptparts = " custom-flash-layout"
DEPENDS += "${EXTRADEPS}"
PARTITION_FILE_cryptparts = "${STAGING_DATADIR}/custom-flash-layout/${PARTITION_LAYOUT_TEMPLATE}"
CBOOTOPTION_FILE = "${STAGING_DATADIR}/bootfiles/cbo.dts"

do_install_append_cryptparts() {
    rm ${D}${datadir}/tegraflash/eks.img
    install -m 0644 ${STAGING_DATADIR}/bootfiles/eks.img ${D}${datadir}/tegraflash/
}
