PACKAGECONFIG = "display machine-id"
EXTRA_GLOBAL_DEFINES:append:secureboot = " CONFIG_ENABLE_FUSED_MACHINE_ID=1"
FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI += "${@bb.utils.contains('DISTRO_FEATURES', 'rauc', 'file://0001-Add-rauc.slot-to-kernel-command-line.patch', '', d)}"

