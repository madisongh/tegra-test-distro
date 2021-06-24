RDEPENDS_${PN}_append = " \
    gptfdisk \
    i2c-tools \
    swupdate \
    swupdate-client \
    swupdate-progress \
    swupdate-tools-hawkbit \
    tegra-bup-payload \
    tegra-eeprom-tool \
    tegra-fuse-tool \   
    tegra-sysinstall-tools \
"

RDEPENDS_${PN}_append_cryptparts = " \
    systemd-conf-crypttab \
"

RRECOMMENDS_${PN}_append = " \
    kernel-module-hid-logitech-hidpp \
    kernel-module-hid-logitech-dj \
    kernel-module-uvcvideo \
"
