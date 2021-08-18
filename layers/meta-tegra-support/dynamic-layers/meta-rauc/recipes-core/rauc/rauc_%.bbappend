FILESEXTRAPATHS:prepend := "${THISDIR}/files:${COREBASE}/meta-testdistro/files/rauc:"

SRC_URI:append:tegra186 = " file://rauc-cboot-script.sh"
SRC_URI:append:tegra194 = " file://rauc-cboot-script.sh"

BASEROOTFSDEV = "/dev/disk/by-partlabel"
BASEROOTFSDEV:cryptparts = "/dev/mapper"

BOOTLOADER = "custom"
BOOTLOADER = "custom"
BOOTLOADER:tegra210 = "uboot"

install:cboot_script() {
    install -d ${D}${sysconfdir}/rauc/scripts
    install -m 0755 ${WORKDIR}/rauc-cboot-script.sh ${D}${sysconfdir}/rauc/scripts/rauc-cboot-script
    sed -i -e's,^#cboot:,,' ${D}${sysconfdir}/rauc/system.conf
}

do_install:append() {
    sed -i -e'/^StateDirectory=/d' -e '/^RuntimeDirectory=/a \StateDirectory=rauc' ${D}${systemd_system_unitdir}/rauc.service
    sed -i -e's,@MACHINE@,${MACHINE},' -e's,@BASEROOTFSDEV@,${BASEROOTFSDEV},' -e's,@BOOTLOADER@,${BOOTLOADER},' ${D}${sysconfdir}/rauc/system.conf
}

do_install:append:tegra186() {
    install:cboot_script
}
do_install:append:tegra194() {
    install:cboot_script
}

PACKAGE_ARCH = "${MACHINE_ARCH}"
RDEPENDS:${PN}:append:tegra = " tegra-boot-tools e2fsprogs-resize2fs"
