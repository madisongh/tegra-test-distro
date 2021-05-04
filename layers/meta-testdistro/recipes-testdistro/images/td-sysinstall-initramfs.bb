TEGRA_INITRD_ROOTFSMOUNT = ""
TEGRA_INITRD_BASEUTILS = "bash"
TEGRA_INITRD_INSTALL = "packagegroup-core-boot \
                        haveged \
                        lvm2-udevrules \
                        tegra-sysinstall-tools \
"

require initramfs-common.inc

SYSTEMD_DEFAULT_TARGET = "multi-user.target"

ROOTFS_POSTPROCESS_COMMAND =. "make_varextra;"

make_varextra() {
    [ -d ${IMAGE_ROOTFS}/var/extra ] || install -d ${IMAGE_ROOTFS}/var/extra
    [ -d ${IMAGE_ROOTFS}/installer ] || install -d ${IMAGE_ROOTFS}/installer
    # And disable systemd's automatic initrd support
    rm -f ${IMAGE_ROOTFS}/etc/initrd-release
}
