inherit bundle

SRC_URI = "file://bootloader-update.sh"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

RAUC_BUNDLE_SLOTS = "rootfs"
RAUC_SLOT_rootfs = "demo-image-base"
RAUC_SLOT_rootfs[fstype] = "ext4"
RAUC_SLOT_rootfs[hooks] = "post-install"

RAUC_BUNDLE_HOOKS[file] = "bootloader-update.sh"

RAUC_KEY_FILE = "${TOPDIR}/openssl-ca/dev/private/development-1.key.pem"
RAUC_CERT_FILE = "${TOPDIR}/openssl-ca/dev/development-1.cert.pem"
RAUC_KEYRING_FILE = "${TOPDIR}/openssl-ca/dev/ca.cert.pem"

RAUC_BUNDLE_COMPATIBLE = "NVIDIA Jetson TX2 development kit"
RAUC_BUNDLE_FORMAT = "verity"
RAUC_BUNDLE_VERSION = "${DISTRO_VERSION}"
RAUC_CASYNC_BUNDLE = "1"
