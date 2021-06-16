require recipes-kernel/linux/linux-tegra_4.9.bb
require td-linux-tegra.inc

KERNEL_PACKAGE_NAME = "td-sysinstall-kernel"
INITRAMFS_IMAGE = "td-sysinstall-initramfs"
INITRAMFS_IMAGE_semi-stateless = "td-sysinstall-initramfs"
INITRAMFS_LINK_NAME = "sysinstall-initramfs"
INITRAMFS_IMAGE_BUNDLE = "1"

KERNEL_ARGS_remove = "systemd.volatile=overlay"
