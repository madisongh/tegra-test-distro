TEGRA_SIGNING_EXCLUDE_TOOLS_secureboot = "1"
TEGRA_SIGNING_EXTRA_DEPS_secureboot = "${DIGSIG_DEPS} gzip-native:do_populate_sysroot"

inherit signing_server l4t_bsp


tegrasign_create_manifest() {
    cat >MANIFEST <<EOF
DTBFILE=${DTBFILE}
ODMDATA=${ODMDATA}
LNXFILE=$1
BOARDID=${TEGRA_BOARDID}
FAB=${TEGRA_FAB}
fuselevel=fuselevel_production
localbootfile=${LNXFILE}
boardcfg=$boardcfg
CHIPREV=${TEGRA_CHIPREV}
BOARDSKU=${TEGRA_BOARDSKU}
BOARDREV=${TEGRA_BOARDREV}
EOF
}

tegraflash_custom_sign_pkg_secureboot() {
    tegrasign_create_manifest ${LNXFILE}
    tar -c -h -z -f ${WORKDIR}/tegrasign-in.tar.gz --exclude=${IMAGE_BASENAME}.img --exclude=${IMAGE_BASENAME}.ext4 *
    digsig_post sign/tegra -F "machine=${MACHINE}" -F "soctype=${SOC_FAMILY}" -F "bspversion=${L4T_VERSION}" -F "artifact=@${WORKDIR}/tegrasign-in.tar.gz" --output ${WORKDIR}/tegrasign-out.tar.gz
    tar -x -z -f ${WORKDIR}/tegrasign-out.tar.gz
    [ "${TEGRA_SIGNING_EXCLUDE_TOOLS}" != "1" ] || cp -R ${STAGING_BINDIR_NATIVE}/${FLASHTOOLS_DIR}/* .
    rm doflash.sh
    mv flashcmd.txt doflash.sh
    chmod +x doflash.sh
    rm -f secureflash.sh
    tegraflash_post_sign_pkg
}

tegraflash_custom_sign_bup_secureboot() {
    tegrasign_create_manifest boot.img
    echo "BUPGENSPECS=${TEGRA_BUPGEN_SPECS}" >>MANIFEST
    tar -c -h -z -f ${WORKDIR}/tegrasign-bupgen-in.tar.gz *
    digsig_post sign/tegra -F "machine=${MACHINE}" -F "soctype=${SOC_FAMILY}" -F "bspversion=${L4T_VERSION}" -F "artifact=@${WORKDIR}/tegrasign-bupgen-in.tar.gz" --output ${WORKDIR}/tegrasign-bupgen-out.tar.gz
    tar -x -z -f ${WORKDIR}/tegrasign-bupgen-out.tar.gz
}
