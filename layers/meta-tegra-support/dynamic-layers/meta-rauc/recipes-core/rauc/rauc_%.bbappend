FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI_append_tegra186 = " file://rauc-cboot-script.sh"
SRC_URI_append_tegra194 = " file://rauc-cboot-script.sh"

BASEROOTFSDEV = "/dev/disk/by-partlabel"
BASEROOTFSDEV_cryptparts = "/dev/mapper"

BOOTLOADER = "custom"
BOOTLOADER = "custom"
BOOTLOADER_tegra210 = "uboot"

install_cboot_script() {
    install -d ${D}${sysconfdir}/rauc/scripts
    install -m 0755 ${WORKDIR}/rauc-cboot-script.sh ${D}${sysconfdir}/rauc/scripts/rauc-cboot-script
    sed -i -e's,^#cboot:,,' ${D}${sysconfdir}/rauc/system.conf
}

do_install_append() {
    sed -i -e'/^StateDirectory=/d' -e '/^RuntimeDirectory=/a \StateDirectory=rauc' ${D}${systemd_system_unitdir}/rauc.service
    sed -i -e's,@MACHINE@,${MACHINE},' -e's,@BASEROOTFSDEV@,${BASEROOTFSDEV},' -e's,@BOOTLOADER@,${BOOTLOADER},' ${D}${sysconfdir}/rauc/system.conf
}

do_install_append_tegra186() {
    install_cboot_script
}
do_install_append_tegra194() {
    install_cboot_script
}

PACKAGE_ARCH = "${MACHINE_ARCH}"
RDEPENDS_${PN}_append_tegra = " tegra-boot-tools e2fsprogs-resize2fs"
