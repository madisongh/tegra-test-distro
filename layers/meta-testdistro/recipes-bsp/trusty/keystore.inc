HOMEPAGE = "https://github.com/madisongh/keystore"
SRC_REPO ?= "github.com/madisongh/keystore.git;protocol=https"
SRCBRANCH ?= "master"
SRC_URI = "git://${SRC_REPO};branch=${SRCBRANCH}"
SRCREV ?= "520962f24edee3169b57ec0433cc792ef6e8ae80"

inherit l4t_bsp

PV = "32.4.3+git${SRCPV}"
