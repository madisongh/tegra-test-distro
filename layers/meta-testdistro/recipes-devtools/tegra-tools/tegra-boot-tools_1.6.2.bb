DESCRIPTION = "Boot-related tools for Tegra platforms"
HOMEPAGE = "https://github.com/madisongh/tegra-boot-tools"
LICENSE = "MIT & BSD-3-Clause"
LIC_FILES_CHKSUM = "file://LICENSE;md5=f547d56278324f08919c3805e5fb8df9"

DEPENDS = "zlib systemd"

SRC_URI = "https://github.com/madisongh/${BPN}/releases/download/v${PV}/${BP}.tar.gz"
SRC_URI[sha256sum] = "3722d3c5d761a05df779d0d47a4a8624ec15f02ab9ecf413cdd26d9f53a8cde5"

EXTRA_OECONF = "--with-systemdsystemunitdir=${systemd_system_unitdir}"

inherit autotools pkgconfig systemd

SYSTEMD_SERVICE_${PN} = "finished-booting.target update_bootinfo.service"
FILES_${PN} += "${libdir}/tmpfiles.d"
