SYSTEMD_DEFAULT_PENULTIMATE_TARGET ?= '${@bb.utils.contains("IMAGE_FEATURES", "x11-base", "graphical.target", "multi-user.target", d)}'
ROOTFS_POSTPROCESS_COMMAND_append = " ${@bb.utils.contains('DISTRO_FEATURES', 'systemd', 'fix_finished_booting_target;', '', d)}"

fix_finished_booting_target() {
    if [ "${SYSTEMD_DEFAULT_TARGET}" = "finished-booting.target" -a \
         -n "${SYSTEMD_DEFAULT_PENULTIMATE_TARGET}" -a \
         -e ${IMAGE_ROOTFS}${systemd_unitdir}/system/${SYSTEMD_DEFAULT_TARGET} -a \
         -e ${IMAGE_ROOTFS}${systemd_unitdir}/system/${SYSTEMD_DEFAULT_PENULTIMATE_TARGET} -a \
         -e ${IMAGE_ROOTFS}${sysconfdir}/systemd/system ]; then
        sed -i -r -e 's,^(Requires|After)=(.*)$,\1=${SYSTEMD_DEFAULT_PENULTIMATE_TARGET},' ${IMAGE_ROOTFS}${systemd_unitdir}/system/${SYSTEMD_DEFAULT_TARGET}
	rm -rf ${IMAGE_ROOTFS}${sysconfdir}/systemd/system/${SYSTEMD_DEFAULT_TARGET}.wants
	install -d ${IMAGE_ROOTFS}${sysconfdir}/systemd/system/${SYSTEMD_DEFAULT_TARGET}.wants
	ln -s ${systemd_unitdir}/system/${SYSTEMD_DEFAULT_PENULTIMATE_TARGET} ${IMAGE_ROOTFS}${sysconfdir}/systemd/system/${SYSTEMD_DEFAULT_TARGET}.wants/
    fi
}
