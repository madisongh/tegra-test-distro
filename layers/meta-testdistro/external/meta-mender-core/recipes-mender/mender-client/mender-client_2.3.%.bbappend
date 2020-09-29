SRC_REPO = "github.com/madisongh/mender.git;protocol=https"
SRC_URI = "git://${SRC_REPO};branch=2.3.x"
SRCREV = "a17fac02bbda84db4a709c0eeb922a7473337022"
PV .= "+git${SRCPV}"

FILESEXTRAPATHS_prepend := "${THISDIR}/${BPN}:"
SRC_URI += "file://artifact-verify-key.pem"

# /data/mender/device_type is machine-specific
PACKAGE_ARCH = "${MACHINE_ARCH}"
