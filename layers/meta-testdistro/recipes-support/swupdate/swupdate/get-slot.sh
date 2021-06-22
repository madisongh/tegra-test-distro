curslot=$(tegra-boot-control --current-slot)
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
