DESCRIPTION = "Installer tegraflash package"
LICENSE = "MIT"

COMPATIBLE_MACHINE = "(tegra)"

PACKAGE_INSTALL = "sysinstall-pkg"
PACKAGE_INSTALL_append_tegra210 = " u-boot-extlinux"

IMAGE_INSTALL_remove = "mender-client"
IMAGE_FEATURES = "empty-root-password allow-empty-password"
IMAGE_LINUGAS = ""

inherit core-image

IMAGE_FSTYPES_forcevariable = "tegraflash"

IMAGE_TEGRAFLASH_KERNEL_tegra186 = "${DEPLOY_DIR_IMAGE}/td-sysinstall-kernel/${KERNEL_IMAGETYPE}-sysinstall-initramfs.cboot"
IMAGE_TEGRAFLASH_KERNEL_tegra194 = "${DEPLOY_DIR_IMAGE}/td-sysinstall-kernel/${KERNEL_IMAGETYPE}-sysinstall-initramfs.cboot"
TEGRAFLASH_PKG_DEPENDS_append_tegra186 = " linux-td-sysinstall:do_deploy"
TEGRAFLASH_PKG_DEPENDS_append_tegra194 = " linux-td-sysinstall:do_deploy"

KERNEL_ARGS_remove = "console=tty0"
KERNEL_ARGS_remove = "systemd.volatile=overlay"

ROOTFS_POSTPROCESS_COMMAND_prepend = "ensure_data_exists; trim_fstab;"
ROOTFS_POSTPROCESS_COMMAND_remove = "mender_update_fstab_file;"
ROOTFS_POSTPROCESS_COMMAND_remove = "mender_create_scripts_version_file;"
ROOTFS_POSTPROCESS_COMMAND_append_tegra210 = " use_installer_initrd;"

ROOTFS_EXTRADEPS = ""
ROOTFS_EXTRADEPS_tegra210 = " linux-td-sysinstall:do_deploy"
do_rootfs[depends] += "${ROOTFS_EXTRADEPS}"

trim_fstab() {
    if [ -e ${IMAGE_ROOTFS}${sysconfdir}/fstab ]; then
        sed -i -n -e'1,/^tmpfs/p' ${IMAGE_ROOTFS}${sysconfdir}/fstab
    fi
}

ensure_data_exists() {
    [ -d "${IMAGE_ROOTFS}/data" ] || install -d "${IMAGE_ROOTFS}/data"
}

semi_stateless_rootfs_hook() {
    :
}

use_installer_initrd() {
    rm -f ${IMAGE_ROOTFS}/boot/initrd ${IMAGE_ROOTFS}/boot/${KERNEL_IMAGETYPE}
    install -m 0644 ${DEPLOY_DIR_IMAGE}/td-sysinstall-kernel/${KERNEL_IMAGETYPE}-sysinstall-initramfs.bin ${IMAGE_ROOTFS}/boot/${KERNEL_IMAGETYPE}
    sed -i -e'/INITRD/d' -e's/root=.*//' ${IMAGE_ROOTFS}/boot/extlinux/extlinux.conf
}
