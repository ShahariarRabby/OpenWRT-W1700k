mkdir -p files/etc files/root files/etc/uci-defaults files/etc/adguardhome files/etc/crontabs

# Copy scripts
scp root@100.118.233.23:/etc/wifi-watchdog.sh files/etc/
scp root@100.118.233.23:/etc/wifi-boot-check.sh files/etc/
chmod +x files/etc/wifi-watchdog.sh files/etc/wifi-boot-check.sh

# Copy all configs at once
scp root@100.118.233.23:/etc/crontabs/root files/etc/crontabs/

# Copy adguard yaml (has your rules)
scp root@100.118.233.23:/etc/adguardhome/adguardhome.yaml files/etc/adguardhome/

# Create firstboot script to enable all services
cat > files/etc/uci-defaults/99-setup.sh << 'EOF'
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
EOF
chmod +x files/etc/uci-defaults/99-setup.sh

# Fix duplicate crontab
sort -u files/etc/crontabs/root > /tmp/cron-clean && mv /tmp/cron-clean files/etc/crontabs/root

# Verify
ls -la files/etc/
ls -la files/etc/uci-defaults/


# Run this on your PC
ssh root@100.118.233.23 "dd if=/dev/mtd2 | gzip" > ~/Desktop/rabby/openwrt_w1700k/OpenW1700kw1700k_ubi_backup_$(date +%Y%m%d).bin.gz && echo "✅ Backup done!"
