SRC_REPO = "github.com/madisongh/mender.git;protocol=https"
SRC_URI = "git://${SRC_REPO};branch=2.3.x"
SRCREV = "83f0f4fa94dca9d637ec5980801397d1e5371b44"
PV .= "+git${SRCPV}"

FILESEXTRAPATHS_prepend := "${THISDIR}/${BPN}:"
SRC_URI += "file://artifact-verify-key.pem"

# /data/mender/device_type is machine-specific
PACKAGE_ARCH = "${MACHINE_ARCH}"
