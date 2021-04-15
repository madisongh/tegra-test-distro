HOMEPAGE = "https://github.com/madisongh/keystore"
SRC_REPO ?= "github.com/madisongh/keystore.git;protocol=https"
SRCBRANCH ?= "master"
SRC_URI = "git://${SRC_REPO};branch=${SRCBRANCH}"
SRCREV ?= "1e2d6e2825394e940b8eacc5c3c9bafb3546d6ca"

inherit l4t_bsp

PV = "32.4.3+git${SRCPV}"
