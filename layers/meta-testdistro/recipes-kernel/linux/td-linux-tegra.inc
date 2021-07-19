FILESEXTRAPATHS_prepend := "${THISDIR}/linux-tegra-4.9:"
SRC_URI += "file://dm-crypt.cfg file://overlayfs.cfg"
SRC_URI_append_secureboot = " file://0001-Drop-security-engine-RSA-priority.patch"
SRC_URI_append_secureboot = " file://test-signing-key.pem"
SRC_URI_append_secureboot = " file://module-signing.cfg"

# Backports from L4T R4.4
SRC_URI += "file://realsense/0001-media-uvc-Add-formats-for-intel-D400-series-cam.patch"
SRC_URI += "file://realsense/0002-media-uvc-Add-metadata-for-Intel-RealSense.patch"
# Patches from meta-intel-realsense
SRC_URI += "file://realsense/realsense_powerlinefrequency_control_fix.patch"
SRC_URI += "file://realsense/discard-frame-on-buffer-overflow.patch"
SRC_URI += "file://realsense/Add-Z16H-format.patch"
SRC_URI += "file://realsense/Add-support-for-RealSense-metadata.patch"
SRC_URI += "file://realsense/tegra.cfg"

DEPENDS += "openssl-native"

do_configure_append_secureboot() {
    if [ ! -e ${S}/certs/test-signing-key.pem ] || \
        ! cmp -s ${WORKDIR}/test-signing-key.pem ${S}/certs/test-signing-key.pem; then
        cp ${WORKDIR}/test-signing-key.pem ${S}/certs/
    fi
}

inherit kernel-module-signing
