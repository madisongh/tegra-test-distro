DESCRIPTION = "Tegra initrd boot count checker for non-U-Boot platforms"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/COPYING.MIT;md5=3da9cfbcb788c80a0384361b4de20420"

SRC_URI = "\
    file://bootcountcheck.sh.in \
    file://bootcountcheck.service.in \
"

S = "${WORKDIR}"
B = "${WORKDIR}/build"

COMPATIBLE_MACHINE = "(tegra186|tegra194)"

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
    install -d ${D}${sbindir}
    install -m 0755 ${B}/bootcountcheck.sh ${D}${sbindir}/bootcountcheck
    install -d ${D}${sysconfdir}/systemd/system
    install -m 0644 ${B}/bootcountcheck.service ${D}${sysconfdir}/systemd/system/
}

SYSTEMD_SERVICE_${PN} = "bootcountcheck.service"
RDEPENDS_${PN} = "initrd-setup tegra-redundant-boot-nvbootctrl tegra-boot-tools"
PACKAGE_ARCH = "${SOC_FAMILY_PKGARCH}"
