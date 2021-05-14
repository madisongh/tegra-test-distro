FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI_append_tegra186 = " file://rauc-cboot-script.sh"
SRC_URI_append_tegra194 = " file://rauc-cboot-script.sh"

install_cboot_script() {
    install -d ${D}${sysconfdir}/rauc/scripts
    install -m 0755 ${WORKDIR}/rauc-cboot-script.sh ${D}${sysconfdir}/rauc/scripts/rauc-cboot-script
}

do_install_append() {
    sed -i -e'/^StateDirectory=/d' -e '/^RuntimeDirectory=/a \StateDirectory=rauc' ${D}${systemd_system_unitdir}/rauc.service
}

do_install_append_tegra186() {
    install_cboot_script
}
do_install_append_tegra194() {
    install_cboot_script
}

PACKAGE_ARCH = "${MACHINE_ARCH}"
RDEPENDS_${PN}_append_tegra186 = " tegra-boot-tools e2fsprogs-resize2fs"
RDEPENDS_${PN}_append_tegra194 = " tegra-boot-tools e2fsprogs-resize2fs"
