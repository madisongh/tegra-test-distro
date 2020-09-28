DESCRIPTION = "Non-encrypted rootfs setup for Tegra initrd"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/COPYING.MIT;md5=3da9cfbcb788c80a0384361b4de20420"

SRC_URI = "\
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

do_install_append() {
    install -d ${D}${sysconfdir}/systemd/system-generators
    install -m 0755 ${B}/bootdev-generator.sh ${D}${sysconfdir}/systemd/system-generators/bootdev-generator
}

RDEPENDS_${PN} = "initrd-setup util-linux-blkid"
PACKAGE_ARCH = "${TEGRA_PKGARCH}"
