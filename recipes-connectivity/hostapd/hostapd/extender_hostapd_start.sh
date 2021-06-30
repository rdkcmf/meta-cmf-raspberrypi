#!/bin/sh

#waiting for the driver initialization
sleep 5

mkdir -p /nvram

wifi=`ifconfig -a | grep wlan -c`
if [ $wifi -lt 3 ];
then
modprobe mac80211_hwsim radios=1
wifi=$((wifi+1))
fi
echo "No. of wireless radios: $wifi"

WIFI0_MAC=`cat /sys/class/net/wlan2/address`
WIFI1_MAC=`cat /sys/class/net/wlan1/address`
echo "2.4GHz Radio MAC: $WIFI0_MAC"
echo "5GHz   Radio MAC: $WIFI1_MAC"

#For 2.4Ghz Radio
iw dev wlan2 interface add wifi0 type __ap
iw dev wlan2 interface add wifi2 type __ap
#For 5Ghz Radio
iw dev wlan1 interface add wifi1 type __ap
iw dev wlan1 interface add wifi3 type __ap

#Set bssid for wifi0
sed -i "/^interface=/c\interface=wifi0" /usr/ccsp/wifi/hostapd0.conf
NEW_MAC=$(echo 0x$WIFI0_MAC| awk -F: '{printf "%02x:%s:%s:%s:%s:%s", strtonum($1)+2, $2, $3, $4 ,$5, $6}')
echo -e "\nbssid=$NEW_MAC" >> /usr/ccsp/wifi/hostapd0.conf

#Set bssid for wifi1
sed -i "/^interface=/c\interface=wifi1" /usr/ccsp/wifi/hostapd1.conf
NEW_MAC=$(echo 0x$WIFI1_MAC| awk -F: '{printf "%02x:%s:%s:%s:%s:%s", strtonum($1)+2, $2, $3, $4 ,$5, $6}')
echo -e "\nbssid=$NEW_MAC" >> /usr/ccsp/wifi/hostapd1.conf

#Set bssid for wifi2
sed -i "/^interface=/c\interface=wifi2" /usr/ccsp/wifi/hostapd2.conf
NEW_MAC=$(echo 0x$WIFI0_MAC| awk -F: '{printf "%02x:%s:%s:%s:%s:%s", strtonum($1)+4, $2, $3, $4 ,$5, $6}')
echo -e "\nbssid=$NEW_MAC" >> /usr/ccsp/wifi/hostapd2.conf

#Set bssid for wifi3
sed -i "/^interface=/c\interface=wifi3" /usr/ccsp/wifi/hostapd3.conf
NEW_MAC=$(echo 0x$WIFI1_MAC| awk -F: '{printf "%02x:%s:%s:%s:%s:%s", strtonum($1)+4, $2, $3, $4 ,$5, $6}')
echo -e "\nbssid=$NEW_MAC" >> /usr/ccsp/wifi/hostapd3.conf

/usr/sbin/hostapd -g /var/run/hostapd/global -B -P /var/run/hostapd-global.pid
