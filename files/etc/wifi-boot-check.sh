#!/bin/sh
# Boot WiFi check — runs once at startup

sleep 30

wifi_up=$(iw dev | grep -c Interface)

if [ "$wifi_up" -lt 2 ]; then
    logger -t wifi-boot "WiFi missing on boot, attempting restart"
    wifi down
    sleep 5
    wifi up
    sleep 20

    wifi_up=$(iw dev | grep -c Interface)
    if [ "$wifi_up" -lt 2 ]; then
        logger -t wifi-boot "WiFi still missing after restart, rebooting"
        reboot
    else
        logger -t wifi-boot "WiFi recovered after restart"
    fi
else
    logger -t wifi-boot "WiFi OK on boot ($wifi_up interfaces)"
fi
