#!/bin/sh

mnt=

cleanup() {
    [ -n "$mnt" ] || return
    for d in sys proc dev run; do
	if mountpoint -q "${mnt}/${d}"; then
	    umount "${mnt}/${d}" >/dev/null 2>&1 || true
	fi
    done
}

if [ "$1" != "slot-post-install" ]; then
    echo "ERR: unrecognized argument: $1" >&2
    exit 1
fi

echo "Installing NVIDIA bootloader update payload"

mnt="$RAUC_SLOT_MOUNT_POINT"
if [ -z "$mnt" ]; then
    echo "ERR: rootfs not mounted" >&2
    exit 1
fi

mount --bind /sys "${mnt}/sys"
mount --bind /proc "${mnt}/proc"
mount --bind /dev "${mnt}/dev"
mount --bind /run "${mnt}/run"
if ! chroot "${mnt}" /usr/bin/tegra-bootloader-update /opt/ota_package/bl_update_payload; then
    echo "ERR: bootloader update failed" >&2
    cleanup
    exit 1
fi
echo "Successful bootloader update"
cleanup
exit 0
