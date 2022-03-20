EXTRADEPS = "bootfiles"
EXTRADEPS:append:cryptparts = " custom-flash-layout"
EXTRADEPS:append:jetson-nano-devkit-sb = " custom-flash-layout"
EXTRADEPS:append:jetson-nano-devkit = " custom-flash-layout"
EXTRADEPS:append:jetson-nano-devkit-emmc = " custom-flash-layout"
EXTRADEPS:append:jetson-tx2-devkit = " custom-flash-layout"
EXTRADEPS:append:jetson-tx1-devkit = " custom-flash-layout"
EXTRADEPS:append:jetson-agx-xavier-devkit = " custom-flash-layout"
EXTRADEPS:append:jetson-xavier-nx-devkit-emmc = " custom-flash-layout"
DEPENDS += "${EXTRADEPS}"
PARTITION_FILE:cryptparts = "${STAGING_DATADIR}/custom-flash-layout/${PARTITION_LAYOUT_TEMPLATE}"
PARTITION_FILE:jetson-tx2-devkit = "${STAGING_DATADIR}/custom-flash-layout/${PARTITION_LAYOUT_TEMPLATE}"
PARTITION_FILE:jetson-tx1-devkit = "${STAGING_DATADIR}/custom-flash-layout/${PARTITION_LAYOUT_TEMPLATE}"
PARTITION_FILE:jetson-nano-devkit-emmc = "${STAGING_DATADIR}/custom-flash-layout/${PARTITION_LAYOUT_TEMPLATE}"
PARTITION_FILE:jetson-agx-xavier-devkit = "${STAGING_DATADIR}/custom-flash-layout/${PARTITION_LAYOUT_TEMPLATE}"
PARTITION_FILE:jetson-xavier-nx-devkit-emmc = "${STAGING_DATADIR}/custom-flash-layout/${PARTITION_LAYOUT_TEMPLATE}"
PARTITION_FILE:jetson-nano-devkit-sb = "${STAGING_DATADIR}/custom-flash-layout/${PARTITION_LAYOUT_TEMPLATE}"
PARTITION_FILE:jetson-nano-devkit = "${STAGING_DATADIR}/custom-flash-layout/${PARTITION_LAYOUT_TEMPLATE}"
CBOOTOPTION_FILE = "${STAGING_DATADIR}/bootfiles/cbo.dts"

do_install:append:cryptparts() {
    rm ${D}${datadir}/tegraflash/eks.img
    install -m 0644 ${STAGING_DATADIR}/bootfiles/eks.img ${D}${datadir}/tegraflash/
}
