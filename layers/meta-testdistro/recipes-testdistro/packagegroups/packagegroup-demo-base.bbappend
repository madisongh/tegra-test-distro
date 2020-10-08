RDEPENDS_${PN}_append = " \
    gptfdisk \
    i2c-tools \
    tegra-bup-payload \
    tegra-eeprom-tool \
    tegra-fuse-tool \   
"

RDEPENDS_${PN}_append_secureboot = " \
    tegra-sysinstall-tools \
    systemd-conf-crypttab \
"

RRECOMMENDS_${PN}_append = " \
    kernel-module-hid-logitech-hidpp \
    kernel-module-hid-logitech-dj \
    kernel-module-uvcvideo \
"
