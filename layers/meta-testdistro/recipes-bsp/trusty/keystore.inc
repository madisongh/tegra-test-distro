HOMEPAGE = "https://github.com/madisongh/keystore"
SRC_REPO ?= "github.com/madisongh/keystore.git;protocol=https"
SRCBRANCH ?= "master"
SRC_URI = "git://${SRC_REPO};branch=${SRCBRANCH}"
SRCREV ?= "937b2e24b2c685f4deb21ed97b499f91fe22a35c"

inherit l4t_bsp

PV = "32.6.1+git${SRCPV}"
