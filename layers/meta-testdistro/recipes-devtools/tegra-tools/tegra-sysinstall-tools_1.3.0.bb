DESCRIPTION = "System installation scripts"
HOMEPAGE = "https://github.com/madisongh/tegra-boot-tools"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://LICENSE;md5=5e5799d70d07956d01af05a7a92ea0d7"

DEPENDS = "zlib"

SRC_URI = "https://github.com/madisongh/tegra-sysinstall/releases/download/v${PV}/tegra-sysinstall-${PV}.tar.gz"
SRC_URI[sha256sum] = "3b5f5a76d6018215455d5fb65837dcd48460f2f431acc742b758c2f15ea38c0a"

S = "${WORKDIR}/tegra-sysinstall-${PV}"

inherit autotools

FILES_${PN} += "${datadir}/tegra-sysinstall"
RDEPENDS_${PN} = "tegra-boot-tools tar cryptsetup keystore-tools tegra-redundant-boot \
                  bash curl util-linux-blkid util-linux-lsblk util-linux-mountpoint \
                  parted gptfdisk e2fsprogs util-linux-mkfs util-linux-mount \
                  util-linux-umount tegra-fuse-tool tegra-eeprom-tool-boardspec"
