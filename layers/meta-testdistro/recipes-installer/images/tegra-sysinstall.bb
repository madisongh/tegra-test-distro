DESCRIPTION = "Installer tegraflash package"
LICENSE = "MIT"

COMPATIBLE_MACHINE = "(tegra)"

PACKAGE_INSTALL = "sysinstall-pkg"

IMAGE_INSTALL_remove = "mender-client"
IMAGE_FEATURES = "empty-root-password allow-empty-password"
IMAGE_LINUGAS = ""

inherit core-image

IMAGE_FSTYPES_forcevariable = "tegraflash"
IMAGE_ROOTFS_SIZE = "2097152"
IMAGE_ROOTFS_MAXSIZE = "2097152"
IMAGE_ROOTFS_EXTRA_SPACE = "0"
IMAGE_OVERHEAD_FACTOR = "1.0"

IMAGE_TEGRAFLASH_KERNEL = "${DEPLOY_DIR_IMAGE}/td-sysinstall-kernel/${KERNEL_IMAGETYPE}-sysinstall-initramfs.cboot"
TEGRAFLASH_PKG_DEPENDS_append = " linux-td-sysinstall:do_deploy"

KERNEL_ARGS_remove = "console=tty0"
KERNEL_ARGS_remove = "systemd.volatile=overlay"

ROOTFS_POSTPROCESS_COMMAND_prepend = "ensure_data_exists; trim_fstab;"
ROOTFS_POSTPROCESS_COMMAND_remove = "mender_update_fstab_file;"
ROOTFS_POSTPROCESS_COMMAND_remove = "mender_create_scripts_version_file;"

trim_fstab() {
    if [ -e ${IMAGE_ROOTFS}${sysconfdir}/fstab ]; then
        sed -i -n -e'1,/^tmpfs/p' ${IMAGE_ROOTFS}${sysconfdir}/fstab
    fi
}

ensure_data_exists() {
    [ -d "${IMAGE_ROOTFS}/data" ] || install -d "${IMAGE_ROOTFS}/data"
}
