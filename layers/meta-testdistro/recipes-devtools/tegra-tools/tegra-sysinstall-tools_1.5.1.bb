DESCRIPTION = "System installation scripts"
HOMEPAGE = "https://github.com/madisongh/tegra-sysinstall"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://LICENSE;md5=5e5799d70d07956d01af05a7a92ea0d7"

DEPENDS = "zlib"

COMPATIBLE_MACHINE = "(tegra)"

SRC_URI = "https://github.com/madisongh/tegra-sysinstall/releases/download/v${PV}/tegra-sysinstall-${PV}.tar.gz"
SRC_URI[sha256sum] = "9abb37874cad3d9957db1eadd5031b6b0ca72be15c41ed3f9defa930b7c802d4"

S = "${WORKDIR}/tegra-sysinstall-${PV}"

inherit autotools

FILES_${PN} += "${datadir}/tegra-sysinstall"
RDEPENDS_${PN} = "tegra-boot-tools-updater tar cryptsetup keystore-tools \
                  bash curl util-linux-blkid util-linux-lsblk util-linux-mountpoint \
                  parted gptfdisk e2fsprogs util-linux-mkfs util-linux-mount \
                  util-linux-umount tegra-fuse-tool tegra-eeprom-tool-boardspec \
                  sysinstall-partition-layout mtd-utils"
