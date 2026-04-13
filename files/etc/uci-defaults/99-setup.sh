#!/bin/sh
/etc/init.d/adguardhome enable
/etc/init.d/tailscale enable
/etc/init.d/unbound enable
/etc/init.d/cloudflared enable
/etc/init.d/cron enable
/etc/init.d/irqbalance enable
/etc/init.d/collectd enable
mkdir -p /etc/adguardhome/data
chmod +x /etc/wifi-watchdog.sh
chmod +x /etc/wifi-boot-check.sh
echo "nameserver 127.0.0.1" > /etc/resolv.conf
chattr +i /etc/resolv.conf
exit 0
