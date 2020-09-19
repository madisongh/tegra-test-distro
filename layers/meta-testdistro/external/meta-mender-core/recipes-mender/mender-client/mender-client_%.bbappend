FILESEXTRAPATHS_prepend := "${THISDIR}/${BPN}:"
SRC_URI_append = " file://artifact-verify-key.pem"

# /data/mender/device_type is machine-specific
PACKAGE_ARCH = "${MACHINE_ARCH}"
