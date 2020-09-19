SRC_REPO = "github.com/madisongh/mender.git;protocol=https"
SRC_URI = "git://${SRC_REPO};branch=2.3.x"
SRCREV = "10710197f5a6e149dd17bac0dc368466001cdcdd"
PV .= "+git${SRCPV}"

FILESEXTRAPATHS_prepend := "${THISDIR}/${BPN}:"
SRC_URI += "file://artifact-verify-key.pem"

# /data/mender/device_type is machine-specific
PACKAGE_ARCH = "${MACHINE_ARCH}"
