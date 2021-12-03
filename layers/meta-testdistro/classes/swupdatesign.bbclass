inherit signing_server

SWUPDATE_SIGNING = ""
SWUPDATE_SIGNING_secureboot = "CUSTOM"
SWUPDATE_SIGNING_METHOD ??= "RSA"
SWUPDATE_SIGN_TOOL = "curl --fail -X POST -F sw-description=@sw-description -F distro=${DISTRO} -F method=${SWUPDATE_SIGNING_METHOD} --output sw-description.sig ${DIGSIG_SERVER}/sign/swupdate"

do_swuimage[depends] += "${DIGSIG_DEPS}"
do_swuimage[dirs] = "${S}"
