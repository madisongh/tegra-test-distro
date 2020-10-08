TEGRA_INITRD_ROOTFSMOUNT = "initrd-noncrypt-setup"
TEGRA_INITRD_ROOTFSMOUNT_secureboot = "initrd-crypt-setup initrd-bootcountcheck"

require initramfs-common.inc

#ROOTFS_POSTPROCESS_COMMAND += "filter_crypttab;"
#
#filter_crypttab() {
#    if [ -e ${IMAGE_ROOTFS}${sysconfdir}/crypttab ]; then
#        sed -i -E -e'/^APP/d' ${IMAGE_ROOTFS}${sysconfdir}/crypttab
#    fi
#}
