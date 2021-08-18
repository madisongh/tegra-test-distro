FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI += "file://0001-Modify-distro-boot-script-for-rauc-support.patch"
SRC_URI += "file://rauc.cfg"

KERNEL_ROOTSPEC = "root=PARTLABEL=${bootpart_label} rootwait"
UBOOT_EXTLINUX_ROOT:append = " rauc.slot=${bootslot}"
