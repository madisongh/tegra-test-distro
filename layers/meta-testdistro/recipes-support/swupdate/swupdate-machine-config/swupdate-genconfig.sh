#!/bin/sh

get_current_slot() {
    local rootdev partlabel
    if [ -e /run/bootdev/rootfs-device ]; then
	rootdev=$(readlink /run/bootdev/rootfs-device)
	partlabel="${rootdev##/dev/mapper/}"
	if [ "${rootdev}" != "${partlabel}" ]; then
	    if [ "${partlabel}" = "${partlabel%%_b}" ]; then
		echo "a"
		return
	    else
		echo "b"
		return
	    fi
	fi
    elif [ -e /run/systemd/volatile-root ]; then
	rootdev="/run/systemd/volatile-root"
    else
	rootdev="/"
    fi
    partlabel=$(lsblk -oPARTLABEL -n "$rootdev" 2>/dev/null)
    if [ -n "$partlabel" ]; then
	if [ "${partlabel}" = "${partlabel%%_b}" ]; then
	    echo "a"
	    return
	else
	    echo "b"
	    return
	fi
    fi
    echo "UNKNOWN"
    return
}

. /etc/os-release

if [ -e /run/mfgdata/serial-number ]; then
    SERIALNUMBER=$(cat /run/mfgdata/serial-number)
elif [ -e /sys/module/tegra_fuse/parameters/tegra_chip_uid ]; then
    SERIALNUMBER=$(cat /sys/module/tegra_fuse/parameters/tegra_chip_uid)
else
    SERIALNUMBER="unknown"
fi

if [ -e /usr/share/tegra-boot-tools/machine-name.conf ]; then
    MODEL=$(cat /usr/share/tegra-boot-tools/machine-name.conf)
else
    MODEL="unknown"
fi
BOOTSLOT=$(get_current_slot)

rm -f /run/swupdate/swupdate.cfg

extrased=
if [ ! -e /usr/share/swupdate/swupdate.pem ]; then
    extrased="-e /public-key-file/d"
fi
sed -e"s,@SWVERSION@,$VERSION_ID," \
    -e"s,@SERIALNUMBER@,$SERIALNUMBER," \
    -e"s,@MODEL@,$MODEL," \
    -e"s,@BOOTSLOT@,$BOOTSLOT," \
    $extrased \
    /usr/share/swupdate/swupdate.cfg.in > /run/swupdate/swupdate.cfg
