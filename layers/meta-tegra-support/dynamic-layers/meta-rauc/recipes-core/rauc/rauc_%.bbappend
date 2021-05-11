FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI_append_tegra186 = " file://rauc-cboot-script.sh"
SRC_URI_append_tegra194 = " file://rauc-cboot-script.sh"

install_cboot_script() {
    install -d ${D}${sysconfdir}/rauc/scripts
    install -m 0755 ${WORKDIR}/rauc-cboot-script.sh ${D}${sysconfdir}/rauc/scripts/rauc-cboot-script
}

do_install_append_tegra() {
    install -d ${D}/data/rauc
}
do_install_append_tegra186() {
    install_cboot_script
}
do_install_append_tegra194() {
    install_cboot_script
}

FILES_${PN} += "/data/rauc"

PACKAGE_ARCH = "${MACHINE_ARCH}"
RDEPENDS_${PN}_append_tegra186 = " tegra-boot-tools"
RDEPENDS_${PN}_append_tegra194 = " tegra-boot-tools"
