FILESEXTRAPATHS_prepend := "${THISDIR}/base-files:"

# Differences from OE-Core default base-files:
#
#   * No /var/volatile (with its tmp and log subdirectories)
#   * /var/tmp is a directory for rootfs-overlay devices, or
#     a symlink to /tmp on non-rootfs-overlay devices
#   * /var/log is a symlink to /run/log on non-rootfs-overlay devices

dirs755_remove = "${localstatedir}/volatile"
dirs1777_remove = "${localstatedir}/volatile/tmp"
dirs755_append_semi-stateless = " ${localstatedir}/extra"
dirs1777_append_semi-stateless = " ${localstatedir}/tmp"
volatiles = ""

make_extra_symlinks() {
    ln -snf ../tmp ${D}${localstatedir}/tmp
    ln -snf ../run/log ${D}${localstatdir}/log
}

make_extra_symlinks_semi-stateless() {
    :
}

do_install_append() {
    make_extra_symlinks
}

# Needed for the fstab entries
RDEPENDS_${PN}_append_semi-stateless = " overlay-setup e2fsprogs-e2fsck e2fsprogs-mke2fs"
RRECOMMENDS_${PN}_append_semi-stateless = " kernel-module-overlay"
