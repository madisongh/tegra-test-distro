DESCRIPTION = "Tegra fuse tool"
HOMEPAGE = "https://github.com/madisongh/tegra-fuse-tool"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://LICENSE;md5=5e5799d70d07956d01af05a7a92ea0d7"

SRC_REPO ?= "github.com/madisongh/tegra-fuse-tool"
SRCBRANCH ?= "master"
SRC_URI = "git://${SRC_REPO};branch=${SRCBRANCH}"
SRCREV = "${AUTOREV}"
PV = "1.0+git${SRCPV}"       

S = "${WORKDIR}/git"

inherit autotools pkgconfig
