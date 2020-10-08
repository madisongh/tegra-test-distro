DESCRIPTION = "System installation scripts"
HOMEPAGE = "https://github.com/madisongh/tegra-boot-tools"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://LICENSE;md5=5e5799d70d07956d01af05a7a92ea0d7"

DEPENDS = "zlib"

SRC_URI = "https://github.com/madisongh/tegra-sysinstall/releases/download/v${PV}/tegra-sysinstall-${PV}.tar.gz"
SRC_URI[sha256sum] = "91fde3e80d0b1d484fdf86008385407850a9dafdc4cfdf316c467ce8857c6def"

S = "${WORKDIR}/tegra-sysinstall-${PV}"

inherit autotools

FILES_${PN} += "${datadir}/tegra-sysinstall"
RDEPENDS_${PN} = "tegra-boot-tools tar cryptsetup keystore-tools tegra-redundant-boot \
                  bash curl util-linux-blkid util-linux-lsblk util-linux-mountpoint \
                  parted gptfdisk e2fsprogs util-linux-mkfs util-linux-mount \
                  util-linux-umount tegra-fuse-tool tegra-eeprom-tool-boardspec"
