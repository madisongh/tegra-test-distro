LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

SRC_URI = "\
    file://sw-description \
    file://swupdate-bl-update.sh \
"

ROOTFS_DEVICE_PATH = "/dev/disk/by-partlabel"
ROOTFS_DEVICE_PATH_cryptparts = "/dev/mapper"

SWUPDATE_IMAGE_NAME ?= "${@d.getVar('BPN').replace('-swupdate-', '-image-')}"

SWUPDATE_IMAGES = "${SWUPDATE_IMAGE_NAME}-${MACHINE}.ext4.gz"

IMAGE_DEPENDS ?= "${SWUPDATE_IMAGE_NAME}"

inherit swupdate swupdatesign

ALTMACHINE = ""
ALTMACHINE_jetson-tx1-devkit = "jetson-tx1"
ALTMACHINE_jetson-tx2-devkit = "jetson-tx2"
ALTMACHINE_jetson-tx2-devkit-tx2i = "jetson-tx2i"
ALTMACHINE_jetson-tx2-devkit-4gb = "jetson-tx2-4gb"
ALTMACHINE_jetson-agx-xavier-devkit = "jetson-xavier"
ALTMACHINE_jetson-agx-xavier-devkit-8gb = "jetson-xavier-8gb"
ALTMACHINE_jetson-nano-devkit = "jetson-nano-qspi-sd"
ALTMACHINE_jetson-nano-devkit-emmc = "jetson-nano-emmc"
ALTMACHINE_jetson-nano-devkit-sb = "jetson-nano-qspi-sd-sb"

do_swdescription_update() {
    if [ -n "${ALTMACHINE}" ]; then
        sed -i -r -e's,[[:space:]]*//ALTMACHINE.*,,' ${WORKDIR}/sw-description
    else
        sed -i -e'/ALTMACHINE/d' ${WORKDIR}/sw-description
    fi
}

addtask swdescription_update after do_unpack do_prepare_recipe_sysroot before do_swuimage
