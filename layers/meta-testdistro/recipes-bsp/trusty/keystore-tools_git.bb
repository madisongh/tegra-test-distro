SUMMARY = "Linux tools for Trusty Keystore app"
DESCRIPTION = "Linux programs for communicating with the keystore TA \
and generating an encrypted keyblob (EKB) for flashing"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://LICENSE;md5=5e5799d70d07956d01af05a7a92ea0d7"

require keystore.inc

DEPENDS += "openssl"

inherit autotools pkgconfig

S = "${WORKDIR}/git/tools"
B = "${WORKDIR}/build"

PACKAGES =+ "${PN}-eksgen"
FILES_${PN}-eksgen = "${bindir}/eksgen"

BBCLASSEXTEND = "native nativesdk"
