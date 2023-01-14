DESCRIPTION = "System installation scripts"
HOMEPAGE = "https://github.com/madisongh/tegra-sysinstall"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://LICENSE;md5=481ed6124b0f84b3a5ad255a328bcaa5"

DEPENDS = "zlib"

SRC_REPO ?= "github.com/madisongh/tegra-sysinstall.git;protocol=https"
SRCBRANCH ?= "master"
SRC_URI = "git://${SRC_REPO};branch=${SRCBRANCH}"
SRCREV = "${AUTOREV}"
PV = "1.7.99+git${SRCPV}"

COMPATIBLE_MACHINE = "(tegra)"

S = "${WORKDIR}/git"

PACKAGECONFIG ??= "${DEFAULT_PACKAGECONFIG}"
DEFAULT_PACKAGECONFIG = ""
DEFAULT_PACKAGECONFIG:cryptparts = "${@'keystore' if (d.getVar('PREFERRED_PROVIDER_virtual/secure-os') or '') == 'tos-keystore' else 'luks-srv'}"
PACKAGECONFIG[luks-srv] = "--with-key-retrieval-command='luks-srv-app --get-unique-pass --context-string=DMCPP',,,luks-srv-app cryptsetup"
PACKAGECONFIG[keystore] = ",,,keystore-tools cryptsetup"

inherit autotools

FILES:${PN} += "${datadir}/tegra-sysinstall"
RDEPENDS:${PN} = "tegra-boot-tools tar \
                  bash curl util-linux-blkid util-linux-lsblk util-linux-mountpoint \
                  parted gptfdisk e2fsprogs util-linux-mkfs util-linux-mount \
                  util-linux-umount tegra-fuse-tool tegra-eeprom-tool-boardspec \
                  sysinstall-partition-layout mtd-utils"
PACKAGE_ARCH = "${MACHINE_ARCH}"
