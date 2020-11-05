EXTRADEPS = ""
EXTRADEPS_jetson-tx2-sb = "custom-flash-layout bootfiles"
EXTRADEPS_jetson-xavier-nx-devkit-emmc-sb = "custom-flash-layout bootfiles"
DEPENDS += "${EXTRADEPS}"
PARTITION_FILE_jetson-tx2-sb = "${STAGING_DATADIR}/custom-flash-layout/${PARTITION_LAYOUT_TEMPLATE}"
PARTITION_FILE_jetson-xavier-nx-devkit-emmc-sb = "${STAGING_DATADIR}/custom-flash-layout/${PARTITION_LAYOUT_TEMPLATE}"
MENDER_PARTITION_FILE_jetson-tx2-sb = "${STAGING_DATADIR}/custom-flash-layout/${PARTITION_LAYOUT_TEMPLATE}"
MENDER_PARTITION_FILE_jetson-xavier-nx-devkit-emmc-sb = "${STAGING_DATADIR}/custom-flash-layout/${PARTITION_LAYOUT_TEMPLATE}"

do_install_append_jetson-tx2-sb() {
    rm ${D}${datadir}/tegraflash/eks.img
    install -m 0644 ${STAGING_DATADIR}/bootfiles/eks.img ${D}${datadir}/tegraflash/
}

do_install_append_jetson-xavier-nx-devkit-emmc-sb() {
    rm ${D}${datadir}/tegraflash/eks.img
    install -m 0644 ${STAGING_DATADIR}/bootfiles/eks.img ${D}${datadir}/tegraflash/
}
