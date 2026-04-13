#!/bin/sh

# === Enable services ===
/etc/init.d/adguardhome enable
/etc/init.d/tailscale enable
/etc/init.d/unbound enable
/etc/init.d/cloudflared enable
/etc/init.d/cron enable
/etc/init.d/irqbalance enable
/etc/init.d/collectd enable

# === App directories ===
mkdir -p /etc/adguardhome/data
chmod +x /etc/wifi-watchdog.sh 2>/dev/null
chmod +x /etc/wifi-boot-check.sh 2>/dev/null

# === DNS: lock resolv.conf to local resolver ===
echo "nameserver 127.0.0.1" > /etc/resolv.conf
chattr +i /etc/resolv.conf

# === LED: Set green as running LED ===
uci set system.led_green=led
uci set system.led_green.name='Status Green'
uci set system.led_green.sysfs='green:status'
uci set system.led_green.trigger='default-on'
uci commit system

# === Firewall: Enable flow offloading (HW + SW) ===
uci set firewall.@defaults[0].flow_offloading='1'
uci set firewall.@defaults[0].flow_offloading_hw='1'
uci commit firewall

# === Network: Load bridge netfilter for NPU L2 offload ===
if ! grep -q "br_netfilter" /etc/modules.d/90-br-netfilter 2>/dev/null; then
    echo "br_netfilter" > /etc/modules.d/90-br-netfilter
fi

exit 0
