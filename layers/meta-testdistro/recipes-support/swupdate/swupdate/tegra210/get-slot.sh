get_current_slot() {
    local rootdev partlabel
    if [ -e /run/bootdev/rootfs-device ]; then
	rootdev="/run/bootdev/rootfs-device"
    elif [ -e /run/systemd/volatile-root ]; then
	rootdev="/run/systemd/volatile-root"
    else
	rootdev="/"
    fi
    partlabel=$(lsblk -oPARTLABEL -n "$rootdev" 2>/dev/null)
    if [ -n "$partlabel" ]; then
	if [ "${partlabel}" = "${partlabel%%_b}" ]; then
	    echo "0"
	    return
	else
	    echo "1"
	    return
	fi
    fi
    echo ""
    return
}

curslot=$(get_current_slot)
# XXX - need to figure out when we should be in installer mode
if [ -z "$curslot" ]; then
    echo "ERR: unable to identify current boot slot" >&2
    exit 1
fi
if [ $curslot -eq 0 ]; then
    SWUPDATE_EXTRA_ARGS="-e system,slot_a"
elif [ $curslot -eq 1 ]; then
    SWUPDATE_EXTRA_ARGS="-e system,slot_b"
else
    echo "ERR: invalid boot slot: $curslot" >&2
    exit 1
fi
SWUPDATE_ARGS="${SWUPDATE_ARGS} ${SWUPDATE_EXTRA_ARGS}"
