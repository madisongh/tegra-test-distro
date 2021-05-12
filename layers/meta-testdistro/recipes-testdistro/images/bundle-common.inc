inherit features_check ${@bb.utils.contains('DISTRO_FEATURES', 'rauc', 'bundle', '', d)}

REQUIRED_DISTRO_FEATURES = "rauc"

SRC_URI = "file://bootloader-update.sh"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

BUNDLE_IMAGE_NAME ?= "${@d.getVar('BPN').replace('-bundle-','-image-')}"

RAUC_BUNDLE_SLOTS = "rootfs"
RAUC_IMAGE_FSTYPE = "ext4"
RAUC_SLOT_rootfs = "${BUNDLE_IMAGE_NAME}"
RAUC_SLOT_rootfs[type] = "image"
RAUC_SLOT_rootfs[fstype] = "ext4"
RAUC_SLOT_rootfs[hooks] = "post-install"

RAUC_BUNDLE_HOOKS[file] = "bootloader-update.sh"

RAUC_BUNDLE_COMPATIBLE = "${MACHINE}"
RAUC_BUNDLE_FORMAT = "verity"
RAUC_BUNDLE_VERSION = "${DISTRO_VERSION}"
