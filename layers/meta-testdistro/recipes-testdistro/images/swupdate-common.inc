LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

SRC_URI = "\
    file://sw-description \
    file://swupdate-bl-update.sh \
"

ROOTFS_DEVICE_PATH = "/dev/disk/by-partlabel"
ROOTFS_DEVICE_PATH_secureboot = "/dev/mapper"

SWUPDATE_IMAGE_NAME ?= "${@d.getVar('BPN').replace('-swupdate-', '-image-')}"

SWUPDATE_IMAGES = "${SWUPDATE_IMAGE_NAME}-${MACHINE}.ext4.gz"

IMAGE_DEPENDS ?= "${SWUPDATE_IMAGE_NAME}"

inherit swupdate swupdatesign
