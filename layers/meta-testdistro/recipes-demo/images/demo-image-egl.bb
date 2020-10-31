DESCRIPTION = "Tegra demo image with no display/window manager."

require demo-image-common.inc

IMAGE_FEATURES += "hwcodecs"

IMAGE_FSTYPES_forcevariable = "tar.gz mender dataimg"

inherit features_check

REQUIRED_DISTRO_FEATURES = "opengl"

CORE_IMAGE_BASE_INSTALL += "packagegroup-demo-egltests"
