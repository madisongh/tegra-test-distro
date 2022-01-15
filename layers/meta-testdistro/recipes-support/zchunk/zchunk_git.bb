DESCRIPTION = "zchunk is a compressed file format that splits the file into independent chunks."
HOMEPAGE = "https://github.com/zchunk/zchunk"
LICENSE = "BSD-2-Clause"
LIC_FILES_CHKSUM = "file://LICENSE;md5=daf6e68539f564601a5a5869c31e5242"

SRC_REPO = "github.com/madisongh/zchunk.git;protocol=https"
SRC_URI = "git://${SRC_REPO};branch=${SRCBRANCH}"
SRCBRANCH = "patches"
SRCREV = "0d049f8d61639019044e8d1e67328e1c678ba3c9"
PV = "1.1.6+git${SRCPV}"

S = "${WORKDIR}/git"

DEPENDS = "curl"

inherit meson pkgconfig

PACKAGECONFIG ?= "openssl zstd"
PACKAGECONFIG[openssl] = "-Dwith-openssl=enabled,-Dwith-openssl=disabled,openssl"
PACKAGECONFIG[zstd] = "-Dwith-zstd=enabled,-Dwith-zstd=disabled,zstd"

BBCLASSEXTEND = "native nativesdk"
