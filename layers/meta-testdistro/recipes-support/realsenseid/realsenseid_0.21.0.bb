DESCRIPTION = "Intel RealSenseID SDK"
HOMEPAGE = "https://www.intelrealsense.com/get-started-intel-realsense-id/"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://LICENSE;md5=937d52c4d8d062521bd7341591d9b6bc"

SRC_REPO ?= "github.com/IntelRealSense/RealSenseID.git;protocol=https"
SRCBRANCH ?= "master"
SRC_URI = "git://${SRC_REPO};branch=${SRCBRANCH}"
# version 0.21.0 (tag 'v.21.0', note typo)
SRCREV ?= "1a2009caa74d987949cf7ce5cb05e5ab0cdbaa71"

S = "${WORKDIR}/git"

inherit cmake

PACKAGECONFIG ??= "preview samples tools"
PACKAGECONFIG[preview] = "-DRSID_PREVIEW=ON,-DRSID_PREVIEW=OFF"
PACKAGECONFIG[samples] = "-DRSID_SAMPLES=ON,-DRSID_SAMPLES=OFF"
PACKAGECONFIG[secure] = "-DRSID_SECURE=ON,-DRSID_SECURE=OFF"
PACKAGECONFIG[tools] = "-DRSID_TOOLS=ON,-DRSID_TOOLS=OFF"

EXTRA_OECMAKE = "-DRSID_INSTALL=ON"

do_configure_prepend() {
   sed -i -e'/CMAKE_INSTALL_RPATH/d' ${S}/CMakeLists.txt
}

do_install_append() {
    if ${@bb.utils.contains('PACKAGECONFIG', 'samples', 'true', 'false', d)}; then
        install -d ${D}${bindir}
        install -m 0755 ${B}/bin/*-sample ${D}${bindir}/
    fi
}

PACKAGES =+ "${PN}-samples ${PN}-tools"
FILES_SOLIBSDEV = ""
SOLIBS = ".so"
FILES_${PN}-tools = "${bindir}/rsid-*"
FILES_${PN}-samples = "${bindir}/*-sample"

