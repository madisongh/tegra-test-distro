DESCRIPTION = "System installation scripts"
HOMEPAGE = "https://github.com/madisongh/tegra-boot-tools"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://LICENSE;md5=5e5799d70d07956d01af05a7a92ea0d7"

DEPENDS = "zlib"

SRC_REPO ?= "github.com/madisongh/tegra-sysinstall.git;protocol=https"
SRCBRANCH ?= "master"
SRC_URI = "git://${SRC_REPO};branch=${SRCBRANCH}"
SRCREV = "35211fbf66d158d8fbc34ee397dd01198e0862be"
PV = "1.3+git${SRCPV}"

S = "${WORKDIR}/git"

inherit autotools

FILES_${PN} += "${datadir}/tegra-sysinstall"
RDEPENDS_${PN} = "tegra-boot-tools tar cryptsetup keystore-tools tegra-redundant-boot \
                  bash curl util-linux-blkid util-linux-lsblk util-linux-mountpoint \
                  parted gptfdisk e2fsprogs util-linux-mkfs util-linux-mount \
                  util-linux-umount tegra-fuse-tool tegra-eeprom-tool-boardspec"
