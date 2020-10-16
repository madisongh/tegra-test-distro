SUMMARY = "jetson-inference"
DESCRIPTION = "jetson-interence by dusty-nv"
LICENSE = "CLOSED"

SRC_URI = "gitsm://github.com/dusty-nv/jetson-inference.git;protocol=https"
SRC_URI += "file://build-fixups.patch"

S = "${WORKDIR}/git"

SRCREV = "76f15f22b4a1ceac1be9281d0639911a183b5930"
PV = "0.0+git${SRCPV}"

DEPENDS = "python3-numpy tensorrt cudnn tegra-libraries v4l-utils glew gstreamer1.0 gstreamer1.0-plugins-base glib-2.0 libxml2"

inherit pkgconfig cmake cuda python3native python3-dir

EXTRA_OECMAKE = "-DBUILD_DEPS=NO -DBUILD_INTERACTIVE=NO \
                 -DPYTHON_BINDING_VERSIONS=${PYTHON_BASEVERSION} \
		 -DPYTHON_BINDING_INSTALL_DIR=${PYTHON_SITEPACKAGES_DIR} \
                 -DNUMPY_PATH=${STAGING_DIR_HOST}${PYTHON_SITEPACKAGES_DIR}/numpy/core"

FILES_SOLIBSDEV = ""
PACKAGES =+ "${PN}-python"
FILES_${PN}-python = "${PYTHON_SITEPACKAGES_DIR} ${bindir}/*.py"
RDEPENDS_${PN}-python = "${PN} python3-core python3-numpy"
FILES_${PN} += "${libdir}/lib*${SOLIBSDEV}"
FILES_${PN}-dev += "${datadir}/jetson-utils"
