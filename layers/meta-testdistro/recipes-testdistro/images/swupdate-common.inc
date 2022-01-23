LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

SRC_URI = "\
    file://sw-description \
    file://swupdate-bl-update.sh \
"

ROOTFS_DEVICE_PATH = "/dev/disk/by-partlabel"
ROOTFS_DEVICE_PATH:cryptparts = "/dev/mapper"

SWUPDATE_IMAGE_NAME ?= "${@d.getVar('BPN').replace('-swupdate-', '-image-')}"

SWUPDATE_IMAGES = "${DEPLOY_DIR_IMAGE}/${SWUPDATE_IMAGE_NAME}-${MACHINE}.tar.gz"

IMAGE_DEPENDS ?= "${SWUPDATE_IMAGE_NAME}"

inherit swupdate swupdatesign

ALTMACHINE = ""
ALTMACHINE:jetson-tx1-devkit = "jetson-tx1"
ALTMACHINE:jetson-tx2-devkit = "jetson-tx2"
ALTMACHINE:jetson-tx2-sb = ""
ALTMACHINE:jetson-tx2-devkit-tx2i = "jetson-tx2i"
ALTMACHINE:jetson-tx2-devkit-4gb = "jetson-tx2-4gb"
ALTMACHINE:jetson-agx-xavier-devkit = "jetson-xavier"
ALTMACHINE:jetson-agx-xavier-devkit-8gb = "jetson-xavier-8gb"
ALTMACHINE:jetson-nano-devkit = "jetson-nano-qspi-sd"
ALTMACHINE:jetson-nano-devkit-emmc = "jetson-nano-emmc"
ALTMACHINE:jetson-nano-devkit-sb = "jetson-nano-qspi-sd-sb"

do_swdescription_update() {
    if [ -n "${ALTMACHINE}" ]; then
        sed -i -r -e's,[[:space:]]*//ALTMACHINE.*,,' ${WORKDIR}/sw-description
    else
        sed -i -n -e'/ALTMACHINE/!p' ${WORKDIR}/sw-description
    fi
    #HSIZE=$(zck_read_header -v ${DEPLOY_DIR_IMAGE}/${SWUPDATE_IMAGE_NAME}-${MACHINE}.ext4.zck | grep "Header size" | cut -d: -f2 | tr -d ' ')
    #rm -f ${WORKDIR}/${SWUPDATE_IMAGE_NAME}-${MACHINE}.header
    #dd if=${DEPLOY_DIR_IMAGE}/${SWUPDATE_IMAGE_NAME}-${MACHINE}.ext4.zck of=${WORKDIR}/${SWUPDATE_IMAGE_NAME}-${MACHINE}.header bs=1 count=$HSIZE
}
do_swdescription_update[depends] += "zchunk-native:do_populate_sysroot ${SWUPDATE_IMAGE_NAME}:do_image_complete"

addtask swdescription_update after do_unpack do_prepare_recipe_sysroot before do_swuimage
