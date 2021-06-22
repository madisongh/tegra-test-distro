#!/bin/sh

mnt=

cleanup() {
    [ -n "$mnt" ] || return
    for d in sys proc dev run; do
	if mountpoint -q "${mnt}/${d}"; then
	    umount "${mnt}/${d}" >/dev/null 2>&1 || true
	fi
    done
    if mountpoint -q "$mnt"; then
	umount "$mnt" > /dev/null 2>&1 || true
    fi
    rmdir "$mnt" >/dev/null 2>&1 || true
}

if [ -z "$1" ]; then
    echo "ERR: missing device name" >&2
    exit 1
fi

echo "Installing NVIDIA bootloader update payload"

mnt=$(mktemp -d -t nvbup.XXXXXX)
if [ -z "$mnt" -o ! -d "$mnt" ]; then
    echo "ERR: could not create directory for mounting install partition" >&2
    exit 1
fi
if ! mount -o ro "$1" "$mnt"; then
    echo "ERR: could not mount $1 for bootloader update" >&2
    cleanup
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
