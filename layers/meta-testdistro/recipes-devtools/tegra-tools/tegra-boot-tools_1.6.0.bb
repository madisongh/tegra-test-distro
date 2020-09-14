DESCRIPTION = "Boot-related tools for Tegra platforms"
HOMEPAGE = "https://github.com/madisongh/tegra-boot-tools"
LICENSE = "MIT & BSD-3-Clause"
LIC_FILES_CHKSUM = "file://LICENSE;md5=f547d56278324f08919c3805e5fb8df9"

DEPENDS = "zlib systemd"

SRC_URI = "https://github.com/madisongh/${BPN}/releases/download/v${PV}/${BP}.tar.gz"
SRC_URI[sha256sum] = "2ed0a79a9abfea24f82a14ab6e62830f9892cfc0b75dd82f024237eab2d69cad"

EXTRA_OECONF = "--with-systemdsystemunitdir=${systemd_system_unitdir}"

inherit autotools pkgconfig systemd

SYSTEMD_SERVICE_${PN} = "finished-booting.target update_bootinfo.service"
FILES_${PN} += "${libdir}/tmpfiles.d"
