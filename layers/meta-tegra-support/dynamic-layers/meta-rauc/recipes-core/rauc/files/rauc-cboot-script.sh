#!/bin/sh
set -e
get_state() {
    local slot=${1##slot}
    local statusline=$(tegra-boot-control --status | grep "^Slot $slot:")
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
    if [ "slot$curslot" != "$1" -o "$2" != "good" ]; then
	echo "Unsupported operation: set-state $1 $2" >&2
	return 1
    fi
    tegra-boot-control --mark-successful
}

get_primary() {
    local curslot=$(tegra-boot-control --current-slot)
    [ -n "$curslot" ] || return 1
    echo "slot$curslot"
}

set_primary() {
    local slot=${1##slot}
    [ "$slot" = "0" -o "$slot" = "1" ] || return 1
    tegra-boot-control --set-active $slot
}

case "$1" in
    get-primary)
	get_primary "$2"
	;;
    set-primary)
	set_primary "$2"
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
