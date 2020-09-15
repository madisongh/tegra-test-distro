DESCRIPTION = "Startup units for initrd"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/COPYING.MIT;md5=3da9cfbcb788c80a0384361b4de20420"

SRC_URI = "\
    file://bootcountcheck.sh.in \
    file://bootcountcheck.service.in \
    file://initrd-system-overrides.conf \
"
SRC_URI_append_secureboot = " \
    file://dmc-passphrase.service.in \
    file://cryptsetup-overrides.conf \
    file://bootdev-generator.sh.in \
"


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
    touch ${D}${sysconfdir}/initrd-release
    install -d ${D}${sysconfdir}/systemd/system.conf.d
    install -m 0644 ${S}/initrd-system-overrides.conf ${D}${sysconfdir}/systemd/system.conf.d/

    install -d ${D}${sbindir}
    install -m 0755 ${B}/bootcountcheck.sh ${D}${sbindir}/bootcountcheck
    install -m 0644 ${B}/bootcountcheck.service ${D}${sysconfdir}/systemd/system/
    install -d ${D}/sysroot
}

do_install_append_secureboot() {
    install -m 0644 ${B}/dmc-passphrase.service ${D}${sysconfdir}/systemd/system/
    install -d ${D}${sysconfdir}/systemd/system/systemd-cryptsetup@.service.d
    install -m 0644 ${S}/cryptsetup-overrides.conf ${D}${sysconfdir}/systemd/system/systemd-cryptsetup@.service.d/
    install -d ${D}${sysconfdir}/systemd/system-generators
    install -m 0755 ${B}/bootdev-generator.sh ${D}${sysconfdir}/systemd/system-generators/bootdev-generator
}

FILES_${PN} += "/sysroot"
SYSTEMD_SERVICE_${PN} = "bootcountcheck.service"
SYSTEMD_SERVICE_${PN}_append_secureboot = " dmc-passphrase.service"
RDEPENDS_${PN} = "systemd tegra-redundant-boot-nvbootctrl tegra-boot-tools"
RDEPENDS_${PN}_append_secureboot = " keystore-tools lvm2-udevrules"
PACKAGE_ARCH = "${MACHINE_ARCH}"
