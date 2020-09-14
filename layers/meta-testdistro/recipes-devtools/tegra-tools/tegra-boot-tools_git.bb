DESCRIPTION = "Boot-related tools for Tegra platforms"
HOMEPAGE = "https://github.com/madisongh/tegra-boot-tools"
LICENSE = "MIT & BSD-3-Clause"
LIC_FILES_CHKSUM = "file://LICENSE;md5=f547d56278324f08919c3805e5fb8df9"

DEPENDS = "zlib"

SRC_REPO ?= "github.com/madisongh/tegra-boot-tools.git;protocol=https"
SRCBRANCH ?= "master"
SRC_URI = "git://${SRC_REPO};branch=${SRCBRANCH}"
SRCREV = "${AUTOREV}"
PV = "1.5+git${SRCPV}"

S = "${WORKDIR}/git"

DEPENDS = "zlib systemd"

EXTRA_OECONF = "--with-systemdsystemunitdir=${systemd_system_unitdir}"

inherit autotools pkgconfig systemd

SYSTEMD_SERVICE_${PN} = "finished-booting.target update_bootinfo.service"
FILES_${PN} += "${libdir}/tmpfiles.d"
