#!/bin/sh

do_get() {
    if [ -z "$1" ]; then
	echo "ERR: get requires variable name" >&2
	return 1
    fi
    tegra-bootinfo --omit-name --get-variable "$1"
}

do_set() {
    if [ -z "$1" ]; then
	echo "ERR: set requires variable name" >&2
	return 1
    fi
    tegra-bootinfo --set-variable "$1" "$2"
}

do_apply() {
    local var val rc=0

    if [ -z "$1" ]; then
	echo "ERR: apply requires file name" >&2
	return 1
    fi

    while IFS== read var val; do
        tegra-bootinfo --set-variable "$var" "$val"
	rc=$?
	[ $rc -eq 0 ] || break
    done < "$1"
    return $rc

}

if [ $# -eq 0 -o -z "$1" ]; then
    echo "ERR: no command (set, get, unset, apply) specified" >&2
    exit 1
fi

cmd="$1"
shift
case "$cmd" in
    get)
	do_get "$@"
	;;
    set|unset)
	do_set "$@"
	;;
    apply)
	do_apply "$@"
	;;
    *)
	echo "ERR: unrecognized command: $cmd" >&2
	exit 1
	;;
esac
