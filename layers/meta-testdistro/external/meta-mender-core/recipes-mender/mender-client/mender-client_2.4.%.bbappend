SRC_REPO = "github.com/madisongh/mender.git;protocol=https"
SRC_URI = "git://${SRC_REPO};branch=2.4.x"
SRCREV = "f90b1871d2fd3eacba88da82a49b6a6eaa1c6695"
PV .= "+git${SRCPV}"

FILESEXTRAPATHS_prepend := "${THISDIR}/${BPN}:"
SRC_URI += "file://artifact-verify-key.pem"

# /data/mender/device_type is machine-specific
PACKAGE_ARCH = "${MACHINE_ARCH}"
