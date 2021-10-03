FILESEXTRAPATHS:prepend := "${THISDIR}/linux-tegra-4.9:"
SRC_URI += "file://dm-crypt.cfg file://overlayfs.cfg"
SRC_URI:append:secureboot = " file://test-signing-key.pem"
SRC_URI:append:secureboot = " file://module-signing.cfg"

DEPENDS += "openssl-native"

do_configure:append:secureboot() {
    if [ ! -e ${S}/certs/test-signing-key.pem ] || \
        ! cmp -s ${WORKDIR}/test-signing-key.pem ${S}/certs/test-signing-key.pem; then
        cp ${WORKDIR}/test-signing-key.pem ${S}/certs/
    fi
}

inherit kernel-module-signing
