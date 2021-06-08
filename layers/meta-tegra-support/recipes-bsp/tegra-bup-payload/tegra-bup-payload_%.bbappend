RDEPENDS:${PN}:remove = "tegra-redundant-boot"
RDEPENDS:${PN}:append = " tegra-boot-tools-updater"

do_install:append:tegra186() {
    install -m 0644 ${DEPLOY_DIR_IMAGE}/${@bupfile_basename(d)}.full_init_only.bup-payload ${D}/opt/ota_package/full_init_payload
}

FILES_${PN}:append:tegra186 = " /opt/ota_package/full_init_payload"

