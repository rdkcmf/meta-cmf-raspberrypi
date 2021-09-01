#!/bin/sh

#waiting for the driver initialization
sleep 5

mkdir -p /nvram
cp /usr/ccsp/wifi/extender_hostapd0.conf /nvram/hostapd0.conf
cp /usr/ccsp/wifi/extender_hostapd1.conf /nvram/hostapd1.conf
cp /usr/ccsp/wifi/extender_hostapd2.conf /nvram/hostapd2.conf
cp /usr/ccsp/wifi/extender_hostapd3.conf /nvram/hostapd3.conf
cp /usr/opensync/lm_log_state.json /nvram/

wifi=`ifconfig -a | grep wlan -c`
if [ $wifi -lt 3 ];
then
#modprobe mac80211_hwsim radios=1
wifi=$((wifi+1))
fi
echo "No. of wireless radios: $wifi"

WIFI0_MAC=`cat /sys/class/net/wlan0/address`
WIFI1_MAC=`cat /sys/class/net/wlan1/address`
echo "2.4GHz Radio MAC: $WIFI0_MAC"
echo "5GHz   Radio MAC: $WIFI1_MAC"

#Set bssid for wifi0
sed -i "/^interface=/c\interface=wifi0" /nvram/hostapd0.conf
NEW_MAC=$(echo 0x$WIFI0_MAC| awk -F: '{printf "%02x:%s:%s:%s:%s:%s", strtonum($1)+2, $2, $3, $4 ,$5, $6}')
sed -i "/^bssid=/c\bssid=$NEW_MAC" /nvram/hostapd0.conf

#Set bssid for wifi1
sed -i "/^interface=/c\interface=wifi1" /nvram/hostapd1.conf
NEW_MAC=$(echo 0x$WIFI1_MAC| awk -F: '{printf "%02x:%s:%s:%s:%s:%s", strtonum($1)+2, $2, $3, $4 ,$5, $6}')
sed -i "/^bssid=/c\bssid=$NEW_MAC" /nvram/hostapd1.conf


#Set bssid for wifi2
sed -i "/^interface=/c\interface=wifi2" /nvram/hostapd2.conf
NEW_MAC=$(echo 0x$WIFI0_MAC| awk -F: '{printf "%02x:%s:%s:%s:%s:%s", strtonum($1)+4, $2, $3, $4 ,$5, $6}')
sed -i "/^bssid=/c\bssid=$NEW_MAC" /nvram/hostapd2.conf

#Set bssid for wifi3
sed -i "/^interface=/c\interface=wifi3" /nvram/hostapd3.conf
NEW_MAC=$(echo 0x$WIFI1_MAC| awk -F: '{printf "%02x:%s:%s:%s:%s:%s", strtonum($1)+4, $2, $3, $4 ,$5, $6}')
sed -i "/^bssid=/c\bssid=$NEW_MAC" /nvram/hostapd3.conf

/usr/sbin/hostapd -g /var/run/hostapd/global -B -P /var/run/hostapd-global.pid
