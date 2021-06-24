#!/bin/sh
machineid=$(systemd-machine-id-setup --print)
# FIXME: hack because I happened to set up with swupdate
authtoken=$(cat /var/lib/swupdate/hawkbit_auth_token)
# :EMXIF
ethaddr=$(cat /sys/class/net/eth0/address)
[ -n "$authtoken" ] || authtoken="@AUTH_TOKEN@"
sed -e"s,@MACHINEID@,$machineid," -e"s,@AUTH_TOKEN@,$authtoken," -e"s,@ETHADDR@,$ethaddr," \
    /etc/rauc-hawkbit-updater/config.conf.template > /run/rauc-hawkbit-updater/config.conf
