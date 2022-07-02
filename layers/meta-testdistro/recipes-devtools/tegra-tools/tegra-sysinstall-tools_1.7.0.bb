DESCRIPTION = "System installation scripts"
HOMEPAGE = "https://github.com/madisongh/tegra-sysinstall"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://LICENSE;md5=5e5799d70d07956d01af05a7a92ea0d7"

DEPENDS = "zlib"

COMPATIBLE_MACHINE = "(tegra)"

# file://0001-tools-common.in-set-x-for-debug.patch
SRC_URI = "https://github.com/madisongh/tegra-sysinstall/releases/download/v${PV}/tegra-sysinstall-${PV}.tar.gz \
           file://0001-lib-tools-common.in-gdb-tegra-buildinfo.patch \
           file://0002-lib-tools-common.in-retry-tegra-bootinfo-on-fail.patch \
           file://0003-lib-tools-common.in-keystoretool-luks-srv-app.patch \
           file://0004-lib-tools-common.in-align-cryptsetup-args-with-NVidia.patch \
           file://0005-lib-tools-common.in-ignore-secure-boot-enabled.patch \
           "
SRC_URI[sha256sum] = "5f2ebb05a4ec243fe9a95b264c4fb3aef5ac66b680bd6b22cfbfbdd799a340af"

S = "${WORKDIR}/tegra-sysinstall-${PV}"

inherit autotools

DISK_ENCRYPTION_CONTEXT ??= "dummy-context"

do_install:append () {
    sed -i -e 's,@DISK_ENCRYPTION_CONTEXT@,${DISK_ENCRYPTION_CONTEXT},g' ${D}${datadir}/tegra-sysinstall/tools-common
}

FILES:${PN} += "${datadir}/tegra-sysinstall"
EXTRA_RDEPENDS = "gdb strace"
EXTRA_RDEPENDS:cryptparts = "cryptsetup luks-srv-app"
RDEPENDS:${PN} = "tegra-boot-tools tar ${EXTRA_RDEPENDS} \
                  bash curl util-linux-blkid util-linux-lsblk util-linux-mountpoint \
                  parted gptfdisk e2fsprogs util-linux-mkfs util-linux-mount \
                  util-linux-umount tegra-fuse-tool tegra-eeprom-tool-boardspec \
                  sysinstall-partition-layout mtd-utils"
