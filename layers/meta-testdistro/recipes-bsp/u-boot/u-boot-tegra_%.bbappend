FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:${COREBASE}/meta-tegra-support/dynamic-layers/meta-rauc/recipes-bsp/u-boot/files:"

# Work around Mender's too-early configuration checks.  They do them
# as a prepend rather than append to avoid cml1_do_configure being
# invoked, but they don't process any configlets.  So add yet another
# prepend so they do get processed, copy-pasting the norma
# do_configure from core u-boot.inc, minus the cml1_do_configure.
do_configure:prepend:mender-uboot() {
    if [ -n "${UBOOT_CONFIG}" ]; then
        unset i j
        for config in ${UBOOT_MACHINE}; do
            i=$(expr $i + 1);
            for type in ${UBOOT_CONFIG}; do
                j=$(expr $j + 1);
                if [ $j -eq $i ]; then
                    oe_runmake -C ${S} O=${B}/${config} ${config}
                    if [ -n "${@' '.join(find_cfgs(d))}" ]; then
                        merge_config.sh -m -O ${B}/${config} ${B}/${config}/.config ${@" ".join(find_cfgs(d))}
                        oe_runmake -C ${S} O=${B}/${config} oldconfig
                    fi
                fi
            done
            unset j
        done
        unset i
        DEVTOOL_DISABLE_MENUCONFIG=true
    else
        if [ -n "${UBOOT_MACHINE}" ]; then
            oe_runmake -C ${S} O=${B} ${UBOOT_MACHINE}
        else
            oe_runmake -C ${S} O=${B} oldconfig
        fi
        merge_config.sh -m .config ${@" ".join(find_cfgs(d))}
    fi
}

