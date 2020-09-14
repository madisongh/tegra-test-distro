DIGSIG_SERVER ??= "http://127.0.0.1:9999"
DIGSIG_SERVER[vardepvalue] = ""
DIGSIG_DEPS = "curl-native:do_populate_sysroot"

digsig_post() {
    local endpoint="$1"
    shift
    [ -n "${DIGSIG_SERVER}" -a -n "$endpoint" ] || exit 1
    curl --silent --fail -X POST "$@" "${DIGSIG_SERVER}/$endpoint"
}
