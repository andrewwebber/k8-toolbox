#!/usr/bin/env bash

set -m

sed -i 's/$vip/'$(echo $KEEPALIVED_VIP)'/g' /etc/keepalived/keepalived.conf
sed -i 's/$internalAdapter/'$(echo $(/opt/bin/network-interface))'/g' /etc/keepalived/keepalived.conf
sed -i 's/$router/'$(echo $ROUTER_ID)'/g' /etc/keepalived/keepalived.conf

/opt/bin/setup-network-environment
source /etc/network-environment
sed -i 's/$host-ip/'$DEFAULT_IPV4'/g' /etc/keepalived/keepalived.conf
cat /etc/keepalived/keepalived.conf

function clean_up {

	# Perform program exit housekeeping
	echo "# Perform program exit housekeeping $(echo $C_PID)"
  kill -SIGTERM $C_PID
  wait $C_PID
	exit
}

trap 'clean_up' SIGHUP SIGINT SIGTERM SIGKILL TERM

# exec "modprobe ip_vs"
if [ $(echo $K8 | grep true) ]; then
	echo "Executing modprobe"
	modprobe ip_vs
fi

/usr/sbin/keepalived --dont-fork --log-console --release-vips --pid /keepalived.pid &

C_PID=$!
wait $C_PID
