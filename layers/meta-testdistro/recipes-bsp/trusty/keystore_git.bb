SUMMARY = "Trusty secure OS with Keystore application"
DESCRIPTION = "Static keystore TA running in Trusty for Tegra platforms."

require keystore.inc
require recipes-bsp/trusty/trusty-l4t.inc

LIC_FILES_CHKSUM:remove = " \
    file://app/nvidia-sample/hwkey-agent/LICENSE;md5=0f2184456a07e1ba42a53d9220768479 \
    file://app/sample/LICENSE;md5=86d3f3a95c324c9479bd8986968f4327 \
"

S = "${WORKDIR}/git"
