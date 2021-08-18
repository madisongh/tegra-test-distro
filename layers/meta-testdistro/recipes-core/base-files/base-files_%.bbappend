FILESEXTRAPATHS:prepend := "${THISDIR}/base-files:"

SRC_URI += "file://fstab-overlays"

# Differences from OE-Core default base-files:
#
#   * No /var/volatile (with its tmp and log subdirectories)
#   * /var/tmp is a directory for rootfs-overlay devices, or
#     a symlink to /tmp on non-rootfs-overlay devices
#   * /var/log is a symlink to /run/log on non-rootfs-overlay devices

dirs755:remove = "${localstatedir}/volatile"
dirs1777:remove = "${localstatedir}/volatile/tmp"
dirs755:append:semi-stateless = " ${localstatedir}/extra"
dirs1777:append:semi-stateless = " ${localstatedir}/tmp"
volatiles = ""

make_extra_symlinks() {
    ln -snf ../tmp ${D}${localstatedir}/tmp
    ln -snf ../run/log ${D}${localstatedir}/log
}

make_extra_symlinks:semi-stateless() {
    :
}

do_install:append() {
    cat ${WORKDIR}/fstab-overlays >>${D}${sysconfdir}/fstab
    make_extra_symlinks
}

# Needed for the fstab entries
RDEPENDS:${PN}:append:semi-stateless = " overlay-setup e2fsprogs-e2fsck e2fsprogs-mke2fs"
RRECOMMENDS:${PN}:append:semi-stateless = " kernel-module-overlay"
