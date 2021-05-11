#!/bin/sh
set -e
get_state() {
    local statusline=$(tegra-boot-control --status | grep "^Slot $1:")
    [ -n "$statusline" ] || return 1
    if echo "$statusline" | grep -q "successful: YES"; then
	echo "good"
    else
	echo "bad"
    fi
    return 0
}

set_state() {
    local curslot=$(tegra-boot-control --current-slot)
    [ -n "$curslot" -a -n "$1" ] || return 1
    if [ $curslot -ne $1 -o "$2" != "good" ]; then
	echo "Unsupported operation: set-state $1 $2" >&2
	return 1
    fi
    tegra-boot-control --mark-successful
}

case "$1" in
    get-primary)
	tegra-boot-control --current-slot
	;;
    set-primary)
	tegra-boot-control --set-active "$2"
	;;
    get-state)
	get_state "$2"
	;;
    set-state)
	set_state "$2" "$3"
	;;
    *)
	echo "Unrecognized command: $1" >&2
	exit 1
	;;
esac
