do_install:append() {
    sed -i -e'/^Before=/a Before=systemd-random-seed.service' ${D}${systemd_system_unitdir}/haveged.service
}

