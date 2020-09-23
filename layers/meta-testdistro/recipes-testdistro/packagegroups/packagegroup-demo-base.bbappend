RDEPENDS_${PN}_append = " \
    i2c-tools \
    tegra-bup-payload \
    tegra-eeprom-tool \
    tegra-fuse-tool \   
"

RDEPENDS_${PN}_append_jetson-tx2-sb = " \
    tegra-sysinstall-tools \
"

RRECOMMENDS_${PN}_append = " \
    kernel-module-hid-logitech-hidpp \
    kernel-module-hid-logitech-dj \
    kernel-module-uvcvideo \
"
