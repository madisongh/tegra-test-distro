EXTRADEPS = ""
EXTRADEPS_cryptparts = "custom-flash-layout bootfiles"
DEPENDS += "${EXTRADEPS}"
PARTITION_FILE_cryptparts = "${STAGING_DATADIR}/custom-flash-layout/${PARTITION_LAYOUT_TEMPLATE}"

do_install_append_cryptparts() {
    rm ${D}${datadir}/tegraflash/eks.img
    install -m 0644 ${STAGING_DATADIR}/bootfiles/eks.img ${D}${datadir}/tegraflash/
}
