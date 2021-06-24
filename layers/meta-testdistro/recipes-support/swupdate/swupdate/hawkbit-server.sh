machineid=$(cat /etc/machine-id)
token=$(cat /var/lib/swupdate/hawkbit_auth_token)
tokenarg=
if [ -n "$token" ]; then
    tokenarg="--targettoken $token"
fi
ustate=$(tegra-bootinfo -n -v ustate)
ustatearg=
if [ -n "$ustate" ]; then
    if [ $ustate -eq 1 ]; then
	ustatearg="-c 2"
    elif [ $ustate -eq 3 ]; then
	ustatearg="-c 3"
    fi
fi
SWUPDATE_SURICATTA_ARGS="-t default --url http://172.16.1.170:9090 --id $machineid $tokenarg $ustatearg"
