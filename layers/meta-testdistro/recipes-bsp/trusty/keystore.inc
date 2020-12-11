HOMEPAGE = "https://github.com/madisongh/keystore"
SRC_REPO ?= "github.com/madisongh/keystore.git;protocol=https"
SRCBRANCH ?= "master"
SRC_URI = "git://${SRC_REPO};branch=${SRCBRANCH}"
SRCREV ?= "351dcb0c585eff9477723833e3e7dc6cb30dccf8"

inherit l4t_bsp

PV = "32.4.3+git${SRCPV}"
