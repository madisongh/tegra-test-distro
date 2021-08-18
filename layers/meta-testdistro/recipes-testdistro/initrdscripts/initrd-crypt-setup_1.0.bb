DESCRIPTION = "Encrypted rootfs setup for Tegra platforms"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/COPYING.MIT;md5=3da9cfbcb788c80a0384361b4de20420"

SRC_URI = " \
    file://dmc-passphrase.service.in \
    file://cryptsetup-overrides.conf \
    file://bootdev-generator.sh.in \
"

COMPATIBLE_MACHINE = "(tegra)"

S = "${WORKDIR}"
B = "${WORKDIR}/build"

inherit systemd

do_compile() {
    for inf in ${S}/*.in; do
        [ -e $inf ] || continue
        outf=$(basename $inf .in)
        sed -e 's,@BINDIR@,${bindir},g' \
            -e 's,@SBINDIR@,${sbindir},g' \
	    -e 's,@BASE_BINDIR@,${base_bindir},g' \
	    -e 's,@BASE_SBINDIR@,${base_sbindir},g' \
	    -e 's,@NONARCH_BASE_LIBDIR@,${nonarch_base_libdir},g' \
	    $inf > ${B}/$outf
    done
}

do_install() {
    install -d ${D}${sysconfdir}/systemd/system
    install -m 0644 ${B}/dmc-passphrase.service ${D}${sysconfdir}/systemd/system/
    install -d ${D}${sysconfdir}/systemd/system/systemd-cryptsetup@.service.d
    install -m 0644 ${S}/cryptsetup-overrides.conf ${D}${sysconfdir}/systemd/system/systemd-cryptsetup@.service.d/
    install -d ${D}${sysconfdir}/systemd/system-generators
    install -m 0755 ${B}/bootdev-generator.sh ${D}${sysconfdir}/systemd/system-generators/bootdev-generator
}

SYSTEMD_SERVICE = " dmc-passphrase.service"
RDEPENDS:${PN} = "initrd-setup keystore-tools lvm2-udevrules"
RCONFLICTS:${PN} = "initrd-noncrypt-setup"
PACKAGE_ARCH = "${TEGRA_PKGARCH}"
