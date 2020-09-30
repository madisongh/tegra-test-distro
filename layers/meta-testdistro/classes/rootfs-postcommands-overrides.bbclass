# No /var/volatile in our builds
ROOTFS_POSTPROCESS_COMMAND_remove = "empty_var_volatile;"

ROOTFS_POSTPROCESS_COMMAND_remove_semi-stateless = "read_only_rootfs_hook;"
ROOTFS_POSTPROCESS_COMMAND_append_semi-stateless = "semi_stateless_rootfs_hook;"

# Adjust the sshd configuration when using semi-stateless setup, so
# we preserve the host keys across boots in the (persistent) /var/lib overlay
semi_stateless_rootfs_hook () {
    if [ -d ${IMAGE_ROOTFS}${sysconfdir}/ssh ]; then
        if [ -e ${IMAGE_ROOTFS}${sysconfdir}/ssh/ssh_host_rsa_key ]; then
            echo "SYSCONFDIR=${sysconfdir}/ssh" >> ${IMAGE_ROOTFS}${sysconfdir}/default/ssh
	else
	    echo "SYSCONFDIR=${localstatedir}/lib/ssh" >> ${IMAGE_ROOTFS}${sysconfdir}/default/ssh
	    rm -f ${IMAGE_ROOTFS}${sysconfdir}/ssh/sshd_config_readonly
	    sed -i -e's,^#HostKey /etc/ssh,HostKey ${localstatedir}/lib/ssh,' ${IMAGE_ROOTFS}${sysconfdir}/ssh/sshd_config
	    sed -i -e'/^\[Service/a StateDirectory=ssh\nRuntimeDirectory=sshd' ${IMAGE_ROOTFS}${systemd_system_unitdir}/sshd@.service
	    sed -i -e'/^ExecStartPre=/d' ${IMAGE_ROOTFS}${systemd_system_unitdir}/sshd.socket
	    sed -i -e's,^RequiresMountsFor=.*,RequiresMountsFor=${localstatedir}/lib /run,' ${IMAGE_ROOTFS}${systemd_system_unitdir}/sshdgenkeys.service
	fi
    fi
}
