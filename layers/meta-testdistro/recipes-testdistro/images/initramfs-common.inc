DESCRIPTION = "Initramfs for tegra test distro"
LICENSE = "MIT"

TEGRA_INITRD_INSTALL ??= ""

TEGRA_INITRD_BASEUTILS ?= "busybox"

TEGRA_INITRD_ROOTFSMOUNT ??= ""
TEGRA_INITRD_BOOTCOUNTCHECK = ""
TEGRA_INITRD_BOOTCOUNTCHECK_tegra186_secureboot = "tegra-boot-tools-earlyboot"
TEGRA_INITRD_BOOTCOUNTCHECK_tegra194_secureboot = "tegra-boot-tools-earlyboot"
TEGRA_INITRD_BOOTCOUNTCHECK_tegra186_testdistro-mender = "tegra-boot-tools-earlyboot"
TEGRA_INITRD_BOOTCOUNTCHECK_tegra194_testdistro-mender = "tegra-boot-tools-earlyboot"

PACKAGE_INSTALL = "\
    tegra-firmware-xusb \
    initrd-setup \
    ${TEGRA_INITRD_ROOTFSMOUNT} \
    ${TEGRA_INITRD_BOOTCOUNTCHECK} \
    ${TEGRA_INITRD_BASEUTILS} \
    ${TEGRA_INITRD_INSTALL} \
"

IMAGE_FEATURES = "empty-root-password"
IMAGE_LINGUAS = ""

COPY_LIC_MANIFEST = "0"
COPY_LIC_DIRS = "0"

COMPATIBLE_MACHINE = "(tegra)"

KERNELDEPMODDEPEND = ""

IMAGE_ROOTFS_SIZE = "32768"
IMAGE_ROOTFS_EXTRA_SPACE = "0"

FORCE_RO_REMOVE ?= "1"
SYSTEMD_DEFAULT_TARGET = "initrd.target"

BAD_RECOMMENDATIONS = "systemd-extra-utils"

inherit core-image

IMAGE_FSTYPES_forcevariable = "${INITRAMFS_FSTYPES}"

ROOTFS_POSTPROCESS_COMMAND_remove = "mender_update_fstab_file;"
ROOTFS_POSTPROCESS_COMMAND_remove = "mender_create_scripts_version_file;"

ROOTFS_POSTPROCESS_COMMAND += "trim_fstab; journal_fixups;"

SSTATE_SKIP_CREATION_task-image-complete = "0"
SSTATE_SKIP_CREATION_task-image-qa = "0"
do_image_complete[vardepsexclude] += "rm_work_rootfs"
IMAGE_POSTPROCESS_COMMAND = ""

# Undo this addition by mender
EXTRA_IMAGEDEPENDS_remove = "u-boot"

inherit nopackages

trim_fstab() {
    if [ -e ${IMAGE_ROOTFS}${sysconfdir}/fstab ]; then
        sed -i -n -e'1,/^tmpfs/p' ${IMAGE_ROOTFS}${sysconfdir}/fstab
    fi
}

# Override this function provided in mender_workarounds
update_version_files () {
    dest="$1"

    if [ -f $dest/${sysconfdir}/os-release ]; then
        sed -i -r -e's,^VERSION=.*,VERSION="${OS_RELEASE_VERSION}",' \
	    -e's,^VERSION_ID=.*,VERSION_ID="${BUILDNAME}",' \
	    -e's,^PRETTY_NAME=.*,PRETTY_NAME="${DISTRO_NAME} ${BUILDNAME}",' \
	    $dest/${sysconfdir}/os-release
    fi

    if [ -f $dest/${sysconfdir}/issue ]; then
        printf "%s \\%s \\l\n\n" "${DISTRO_NAME} ${BUILDNAME}" "n" >$dest/${sysconfdir}/issue
    fi

    if [ -f $dest/${sysconfdir}/issue.net ]; then
        printf "%s %%h\n\n" "${DISTRO_NAME} ${BUILDNAME}" >$dest/${sysconfdir}/issue.net
    fi
}

journal_fixups() {
    rm -rf ${IMAGE_ROOTFS}${systemd_unitdir}/journal.conf.d
    rm -rf ${IMAGE_ROOTFS}${localstatedir}/log/journal
}
