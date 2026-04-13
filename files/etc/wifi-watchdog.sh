#!/bin/sh

DEVICE1="172.16.3.158"
DEVICE2="172.16.3.170"
DEVICE3="172.16.3.133"
COUNTER_FILE="/tmp/wifi_fail_count"

COUNT=$(cat $COUNTER_FILE 2>/dev/null || echo 0)

ping -c3 -W2 $DEVICE1 > /dev/null 2>&1
R1=$?
ping -c3 -W2 $DEVICE2 > /dev/null 2>&1
R2=$?
ping -c3 -W2 $DEVICE3 > /dev/null 2>&1
R3=$?

if [ $R1 -ne 0 ] && [ $R2 -ne 0 ] && [ $R3 -ne 0 ]; then
    COUNT=$((COUNT + 1))
    echo $COUNT > $COUNTER_FILE
    logger -t wifi-watchdog "All 3 unreachable, fail count: $COUNT"

    if [ $COUNT -eq 2 ]; then
        logger -t wifi-watchdog "Minute 2: restarting WiFi"
        wifi down
        sleep 5
        wifi up

    elif [ $COUNT -eq 3 ]; then
        logger -t wifi-watchdog "Minute 3: WiFi restart failed, rebooting"
        echo 0 > $COUNTER_FILE
        reboot
    fi
else
    if [ $COUNT -gt 0 ]; then
        logger -t wifi-watchdog "WiFi recovered, resetting counter"
    fi
    echo 0 > $COUNTER_FILE
fi
