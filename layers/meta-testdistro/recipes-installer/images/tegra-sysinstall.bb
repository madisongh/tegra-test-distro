DESCRIPTION = "Installer tegraflash package"
LICENSE = "MIT"

COMPATIBLE_MACHINE = "(tegra)"

IMAGE_INSTALL = "packagegroup-core-boot \
                 haveged \
                 lvm2-udevrules \
                 sysinstall-pkg \
                 tegra-sysinstall-tools \
"
IMAGE_FEATURES = "empty-root-password allow-empty-password"
IMAGE_LINUGAS = ""

inherit core-image

IMAGE_FSTYPES = "tegraflash"
IMAGE_ROOTFS_SIZE = "2097152"
IMAGE_ROOTFS_MAXSIZE = "2097152"
IMAGE_ROOTFS_EXTRA_SPACE = "0"
IMAGE_OVERHEAD_FACTOR = "1.0"
KERNEL_ARGS_append = " root=PARTLABEL=INSTALLER"
KERNEL_ARGS_remove = "console=tty0"

ROOTFS_POSTPROCESS_COMMAND_prepend = "ensure_data_exists; trim_fstab;"

trim_fstab() {
    if [ -e ${IMAGE_ROOTFS}${sysconfdir}/fstab ]; then
        sed -i -n -e'1,/^tmpfs/p' ${IMAGE_ROOTFS}${sysconfdir}/fstab
    fi
}

ensure_data_exists() {
    [ -d "${IMAGE_ROOTFS}/data" ] || install -d "${IMAGE_ROOTFS}/data"
}
