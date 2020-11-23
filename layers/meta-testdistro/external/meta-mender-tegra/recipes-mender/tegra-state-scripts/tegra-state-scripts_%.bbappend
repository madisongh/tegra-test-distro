FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

do_compile_tegra210() {
    cp ${S}/redundant-boot-install-script-uboot ${MENDER_STATE_SCRIPTS_DIR}/ArtifactInstall_Leave_80_bl-update
}

