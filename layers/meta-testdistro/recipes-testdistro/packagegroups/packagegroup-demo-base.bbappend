RDEPENDS:${PN}:append = " \
    gptfdisk \
    i2c-tools \
    swupdate \
    swupdate-client \
    swupdate-progress \
    swupdate-tools-ipc \
    tegra-bup-payload \
    tegra-eeprom-tool \
    tegra-fuse-tool \   
    tegra-sysinstall-tools \
"

RDEPENDS:${PN}:append:cryptparts = " \
    systemd-conf-crypttab \
"

RRECOMMENDS:${PN}:append = " \
    kernel-module-hid-logitech-hidpp \
    kernel-module-hid-logitech-dj \
    kernel-module-uvcvideo \
"
