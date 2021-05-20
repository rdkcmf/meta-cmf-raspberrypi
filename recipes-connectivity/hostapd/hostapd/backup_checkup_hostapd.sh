#!/bin/sh

##############################################################################################################
####################################### Hostapd Process Check ################################################
##############################################################################################################

############# Read the SSID and radio status of 2g&5g files from tmp folder ###############

while true
do

Radio_2g=`cat /var/Get2gRadioEnable.txt`
Radio_5g=`cat /var/Get5gRadioEnable.txt`

echo "Radios : $Radio_2g $Radio_5g"

Private_2g=`cat /var/Get2gssidEnable.txt`
Private_5g=`cat /var/Get5gssidEnable.txt`

Public_2g=`cat /var/GetPub2gssidEnable.txt`
Public_5g=`cat /var/GetPub5gssidEnable.txt`

echo "SSID status Private : $Private_2g $Private_5g Public : $Public_2g $Public_5g"

################ Get the SSID status values from dmcli commad ################################

P_2g=`dmcli eRT getv Device.WiFi.SSID.1.Enable | grep bool | cut -d ':' -f3 | cut -d ' ' -f2`
pub_2g=`dmcli eRT getv Device.WiFi.SSID.5.Enable | grep bool | cut -d ':' -f3 | cut -d ' ' -f2`
P_5g=`dmcli eRT getv Device.WiFi.SSID.2.Enable | grep bool | cut -d ':' -f3 | cut -d ' ' -f2`
pub_5g=`dmcli eRT getv Device.WiFi.SSID.6.Enable | grep bool | cut -d ':' -f3 | cut -d ' ' -f2`

echo "dmcli : $P_2g $pub_2g $P_5g $pub_5g"

################ Checking the hostapd process  #################################################

hostapd_check ()
{
echo "SSID status : $1 SSID_Enable : $2  Index : $3"
if [ "$1" -eq 1 ] || [ "$2" = "true" ] ; then
	HOSTAPD_PID=`ps aux | grep hostapd$3 | grep -v grep | wc -l`
    		if [ "$HOSTAPD_PID" -eq 1 ] ; then
			echo "Hostapd Process is $3 running"
		else
			echo "Hostapd process is $3 not running"
			if [ "$3" -eq 0 ] ; then
				echo "Private Wifi 2g have some trouble "
				rmmod brcmfmac
			        sleep 1
			        modprobe brcmfmac
			        sleep 2
			        hostapd -B /nvram/hostapd0.conf
			else
				hostapd -B /nvram/hostapd$3.conf
			fi
		fi
fi	
}

if [ "$Radio_2g" -eq 1 ] && [ `dmcli eRT getv Device.WiFi.Radio.1.Enable | grep bool | cut -d ':' -f3 | cut -d ' ' -f2` = "true" ] ; then
		hostapd_check $Private_2g $P_2g 0
		hostapd_check $Public_2g $pub_2g 4
else
 		echo "2G Radio is currently disabled"	
fi


if [ "$Radio_5g" -eq 1 ] && [ `dmcli eRT getv Device.WiFi.Radio.2.Enable | grep bool | cut -d ':' -f3 | cut -d ' ' -f2` = "true" ] ; then
		hostapd_check $Private_5g $P_5g 1
		hostapd_check $Public_5g $pub_5g 5
else
 		echo "5G Radio is currently disabled"	
fi

sleep 180

done
