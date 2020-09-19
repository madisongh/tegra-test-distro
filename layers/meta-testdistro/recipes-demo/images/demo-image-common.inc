IMAGE_FEATURES += "ssh-server-openssh"

LICENSE = "MIT"

inherit core-image

CORE_IMAGE_BASE_INSTALL += "packagegroup-demo-base packagegroup-demo-basetests"
CORE_IMAGE_BASE_INSTALL += "${@'packagegroup-demo-systemd' if d.getVar('VIRTUAL-RUNTIME_init_manager') == 'systemd' else ''}"

# Also make a convenience tarball of the contents of /data for use
# with the system installer.  See the definition of IMAGE_CMD_tar in
# image_types.bbclass for the pattern used here.
IMAGE_CMD_dataimg_append() {
    ${IMAGE_CMD_TAR} --numeric-owner -czf ${IMGDEPLOYDIR}/${IMAGE_NAME}.data.tar.gz -C ${IMAGE_ROOTFS}/data . || [ $? -eq 1 ]
    # Have to create the symlink ourselves
    ln -sf ${IMAGE_NAME}.data.tar.gz ${IMGDEPLOYDIR}/${IMAGE_LINK_NAME}.data.tar.gz
}

inherit nopackages
