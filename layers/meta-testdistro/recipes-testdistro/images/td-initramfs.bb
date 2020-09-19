DESCRIPTION = "Initramfs for testdistro secureboot platforms"
LICENSE = "MIT"

TEGRA_INITRD_INSTALL ??= ""

TEGRA_INITRD_BASEUTILS ?= "busybox"

PACKAGE_INSTALL = "\
    tegra-firmware-xusb \
    initrd-setup \
    ${TEGRA_INITRD_BASEUTILS} \
    ${ROOTFS_BOOTSTRAP_INSTALL} \
    ${TEGRA_INITRD_INSTALL} \
"

IMAGE_FEATURES = "empty-root-password"
IMAGE_LINGUAS = ""

COPY_LIC_MANIFEST = "0"
COPY_LIC_DIRS = "0"

COMPATIBLE_MACHINE = "(secureboot)"

KERNELDEPMODDEPEND = ""

IMAGE_ROOTFS_SIZE = "32768"
IMAGE_ROOTFS_EXTRA_SPACE = "0"

FORCE_RO_REMOVE ?= "1"

inherit core-image

IMAGE_FSTYPES_forcevariable = "${INITRAMFS_FSTYPES}"

ROOTFS_POSTPROCESS_COMMAND_remove = "mender_update_fstab_file;"
ROOTFS_POSTPROCESS_COMMAND_remove = "mender_create_scripts_version_file;"

SSTATE_SKIP_CREATION_task-image-complete = "0"
SSTATE_SKIP_CREATION_task-image-qa = "0"
do_image_complete[vardepsexclude] += "rm_work_rootfs"
IMAGE_POSTPROCESS_COMMAND = ""

inherit nopackages
