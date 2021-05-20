#!/bin/sh

sleep 5

########################### Getting Total Number of wireless Interface Count #################
wifi=`ifconfig -a | grep wlan | wc -l`

echo "wireless count is $wifi"

########################### Getting Total Number of Channel Count for all Interfaces #############

wifi_wlan0=`iwlist wlan0 freq | grep wlan0 | tr -s ' ' | cut -d ' ' -f2`
echo "Channel Count for wlan0 = $wifi_wlan0"
 
wifi_wlan1=`iwlist wlan1 freq | grep wlan1 | tr -s ' ' | cut -d ' ' -f2`
echo "Channel Count for wlan1 = $wifi_wlan1"
 
wifi_wlan2=`iwlist wlan2 freq | grep wlan2 | tr -s ' ' | cut -d ' ' -f2`
echo "Channel Count for wlan2 = $wifi_wlan2" 

wifi_wlan3=`iwlist wlan3 freq | grep wlan3 | tr -s ' ' | cut -d ' ' -f2`
echo "Channel Count for wlan3 = $wifi_wlan3"


wifi_wlan0_b=`iwconfig wlan0|grep "Power Management:on" | wc -l`
wifi_wlan1_b=`iwconfig wlan1|grep "Power Management:on" | wc -l`
wifi_wlan2_b=`iwconfig wlan2|grep "Power Management:on" | wc -l`
wifi_wlan3_b=`iwconfig wlan3|grep "Power Management:on" | wc -l`

#HOTSPOT_ENABLE=`dmcli eRT getv Device.DeviceInfo.X_COMCAST_COM_xfinitywifiEnable | grep value | cut -f3 -d : | cut -f2 -d" "`
HOTSPOT_ENABLE=`dmcli eRT psmgetv dmsb.hotspot.enable | grep value | cut -f3 -d : | cut -f2 -d" "`

############################### Current Hostapd Securities support are AES or AES+TKIP only ####################################
SECURITY_2g=`cat /nvram/hostapd0.conf | grep rsn_pairwise`
SECURITY_5g=`cat /nvram/hostapd1.conf | grep rsn_pairwise` 
echo "Security Type is $SECURITY_2g $SECURITY_5g "
if [ "$SECURITY_2g" = "rsn_pairwise=TKIP" ] ; then
        sed -i "s/$SECURITY_2g/rsn_pairwise=CCMP/g" /nvram/hostapd0.conf 
fi 
if [ "$SECURITY_5g" = "rsn_pairwise=TKIP" ] ; then 
        sed -i "s/$SECURITY_5g/rsn_pairwise=CCMP/g" /nvram/hostapd1.conf
fi 

echo "HOTSPOT_ENABLE is $HOTSPOT_ENABLE"

########## Get the old Interface and update the new interface and start the hostapd process with corresponding bands ########

update_wirelessinterface_private_wifi_2G () {
	wifi_oldinterface=`cat /nvram/hostapd0.conf | grep interface= | head -n1` 
	echo "wireless old private wifi 2G interface $wifi_oldinterface"
	sed -i "s/$wifi_oldinterface/interface=$1/g" /nvram/hostapd0.conf 
	sleep 2
	hostapd -B -P /run/hostapd.pid /nvram/hostapd0.conf
}

update_wirelessinterface_private_wifi_5G () {
	wifi_oldinterface=`cat /nvram/hostapd1.conf | grep interface= | head -n1` 
	echo "wireless old private wifi 5G interface $wifi_oldinterface" 
	sed -i "s/$wifi_oldinterface/interface=$1/g" /nvram/hostapd1.conf 
	sleep 2
	hostapd -B -P /run/hostapd.pid /nvram/hostapd1.conf 
}

update_wirelessinterface_public_wifi_2G () {
	wifi_oldinterface=`cat /nvram/hostapd4.conf | grep interface= | head -n1` 
	echo "wireless old public wifi 2G interface $wifi_oldinterface" 
	sed -i "s/$wifi_oldinterface/interface=$1/g" /nvram/hostapd4.conf 
	sleep 2
	hostapd -B -P /run/hostapd.pid /nvram/hostapd4.conf
}

update_wirelessinterface_public_wifi_5G () {
	wifi_oldinterface=`cat /nvram/hostapd5.conf | grep interface= | head -n1` 
	echo "wireless old public wifi 2G interface $wifi_oldinterface" 
	sed -i "s/$wifi_oldinterface/interface=$1/g" /nvram/hostapd5.conf 
	sleep 2
	hostapd -B -P /run/hostapd.pid /nvram/hostapd5.conf 
}
	

######################## Get the old interface and update the new interface #################

Get_wirelessinterface_private_wifi_2G () {
	wifi_oldinterface=`cat /nvram/hostapd0.conf | grep interface= | head -n1`
        echo "wireless old private wifi 2G interface $wifi_oldinterface" 
	sed -i "s/$wifi_oldinterface/interface=$1/g" /nvram/hostapd0.conf
}

Get_wirelessinterface_private_wifi_5G () {
	wifi_oldinterface=`cat /nvram/hostapd1.conf | grep interface= | head -n1`
        echo "wireless old private wifi 5G interface $wifi_oldinterface" 
	sed -i "s/$wifi_oldinterface/interface=$1/g" /nvram/hostapd1.conf
}

Get_wirelessinterface_public_wifi_2G () {
	wifi_oldinterface=`cat /nvram/hostapd4.conf | grep interface= | head -n1`
        echo "wireless old public wifi 2G interface $wifi_oldinterface" 
	sed -i "s/$wifi_oldinterface/interface=$1/g" /nvram/hostapd4.conf
}

Get_wirelessinterface_public_wifi_5G () {
	wifi_oldinterface=`cat /nvram/hostapd5.conf | grep interface= | head -n1`
        echo "wireless old public wifi 5G interface $wifi_oldinterface" 
	sed -i "s/$wifi_oldinterface/interface=$1/g" /nvram/hostapd5.conf
}


######################################## Single Wireless Interface ##############################

if [ $wifi == 1 ];then   ############## RPI In-built chipset Broadcom driver ############

echo "Entering into single Wireless Interface Scenario" 
############### Private wifi for 2.4Ghz #################

wirelessinterface=wlan0
update_wirelessinterface_private_wifi_2G $wirelessinterface
Get_wirelessinterface_private_wifi_5G wlan1
Get_wirelessinterface_public_wifi_2G wlan2
Get_wirelessinterface_public_wifi_5G wlan3

####################################### Single dongle and Two Wireless Interfaces##################################
elif [ $wifi == 2 ];then  ######## It may be two 2g support chipset dongles / one 2g and one 5g chipset supported dongles ####

echo "Entering into Double Wireless Interface Scenario" 

########### Private wifi for 2.4Ghz ############(in-built chipset for both rpiB/B+ Boards)
if [ $wifi_wlan0_b == 1 ];then 
	flag=wlan0
	update_wirelessinterface_private_wifi_2G $flag

elif [ $wifi_wlan1_b == 1 ];then
	flag=wlan1 
	update_wirelessinterface_private_wifi_2G $flag
fi

##################### Xfinity-wifi for 2Ghz ###########
if [ "$flag" == "wlan0" ];then
	flag=wlan1
	if [ $wifi_wlan1 -ge 13 ] && [ $wifi_wlan1 -le 14 ];then
		update_wirelessinterface_public_wifi_2G $flag
		Get_wirelessinterface_private_wifi_5G wlan2
		Get_wirelessinterface_public_wifi_5G wlan3
	elif [ $wifi_wlan1 -gt 15 ];then
                update_wirelessinterface_private_wifi_5G $flag
                Get_wirelessinterface_public_wifi_2G wlan2
                Get_wirelessinterface_public_wifi_5G wlan3
	fi
elif [ "$flag" == "wlan1" ];then
	flag=wlan0	
	if [ $wifi_wlan0 -ge 13 ] && [ $wifi_wlan0 -le 14 ];then
		update_wirelessinterface_public_wifi_2G $flag
		Get_wirelessinterface_private_wifi_5G wlan2
		Get_wirelessinterface_public_wifi_5G wlan3
        elif [ $wifi_wlan0 -gt 15 ];then
                update_wirelessinterface_private_wifi_5G $flag
                Get_wirelessinterface_public_wifi_2G wlan2
                Get_wirelessinterface_public_wifi_5G wlan3
	fi
fi


################################################ Single dongle and Three Wireless Interfaces #####################################

elif [ $wifi == 3 ];then


echo "Entering into Three Wireless Interfaces Scenario" 

##################### private wifi for 2.4Ghz ##################

if [ $wifi_wlan0_b == 1 ] ;then
	flag=wlan0
	update_wirelessinterface_private_wifi_2G $flag

elif [ $wifi_wlan1_b == 1 ];then 
	flag=wlan1
	update_wirelessinterface_private_wifi_2G $flag

elif [ $wifi_wlan2_b == 1 ];then 
	flag=wlan2 
	update_wirelessinterface_private_wifi_2G $flag
fi

##################### Private wifi for 5Ghz and Xfinity-wifi for 5Ghz / public wifi for 2g and private wifi for 5g ################################

if [ "$flag" == "wlan0" ] ; then
        if [ $wifi_wlan1 -ge 13 ] && [ $wifi_wlan1 -le 14 ]; then
                flag_2g=wlan1
                flag_5g=wlan2
                update_wirelessinterface_public_wifi_2G $flag_2g
                update_wirelessinterface_private_wifi_5G $flag_5g
                Get_wirelessinterface_public_wifi_5G wlan3

        elif [ $wifi_wlan2 -ge 13 ] && [ $wifi_wlan2 -le 14 ]; then
                flag_2g=wlan2
                flag_5g=wlan1
                update_wirelessinterface_public_wifi_2G $flag_2g
                update_wirelessinterface_private_wifi_5G $flag_5g
                Get_wirelessinterface_public_wifi_5G wlan3

        elif [ $wifi_wlan1 -gt 15 ] && [ $wifi_wlan2 -gt 15 ]; then
                private_5g=wlan1
                public_5g=wlan2
                update_wirelessinterface_private_wifi_5G $private_5g
                update_wirelessinterface_public_wifi_5G $public_5g
                Get_wirelessinterface_public_wifi_2G wlan3
        fi

elif [ "$flag" == "wlan1" ] ; then
        if [ $wifi_wlan0 -ge 13 ] && [ $wifi_wlan0 -le 14 ]; then
                flag_2g=wlan0
                flag_5g=wlan2
                update_wirelessinterface_public_wifi_2G $flag_2g
                update_wirelessinterface_private_wifi_5G $flag_5g
                Get_wirelessinterface_public_wifi_5G wlan3

        elif [ $wifi_wlan2 -ge 13 ] && [ $wifi_wlan2 -le 14 ]; then
                flag_2g=wlan2
                flag_5g=wlan0
                update_wirelessinterface_public_wifi_2G $flag_2g
                update_wirelessinterface_private_wifi_5G $flag_5g
                Get_wirelessinterface_public_wifi_5G wlan3

        elif [ $wifi_wlan0 -gt 15 ] && [ $wifi_wlan2 -gt 15 ]; then
                private_5g=wlan0
                public_5g=wlan2
                update_wirelessinterface_private_wifi_5G $private_5g
                update_wirelessinterface_public_wifi_5G $public_5g
                Get_wirelessinterface_public_wifi_2G wlan3
        fi

elif [ "$flag" == "wlan2" ] ; then
        if [ $wifi_wlan0 -ge 13 ] && [ $wifi_wlan0 -le 14 ]; then
                flag_2g=wlan0
                flag_5g=wlan1
                update_wirelessinterface_public_wifi_2G $flag_2g
                update_wirelessinterface_private_wifi_5G $flag_5g
                Get_wirelessinterface_public_wifi_5G wlan3

        elif [ $wifi_wlan1 -ge 13 ] && [ $wifi_wlan1 -le 14 ]; then
                flag_2g=wlan1
                flag_5g=wlan0
                update_wirelessinterface_public_wifi_2G $flag_2g
                update_wirelessinterface_private_wifi_5G $flag_5g
                Get_wirelessinterface_public_wifi_5G wlan3

        elif [ $wifi_wlan0 -gt 15 ] && [ $wifi_wlan1 -gt 15 ]; then
                private_5g=wlan0
                public_5g=wlan1
                update_wirelessinterface_private_wifi_5G $private_5g
                update_wirelessinterface_public_wifi_5G $public_5g
                Get_wirelessinterface_public_wifi_2G wlan3
        fi
fi
################################################ Two dongles and Four Wireless Interfaces #####################################

elif [ $wifi == 4 ];then


echo "Entering into Four Wireless Interfaces Scenario"
 
##################### private wifi for 2.4Ghz ##################

if [ $wifi_wlan0_b == 1 ];then
        flag=wlan0
        update_wirelessinterface_private_wifi_2G $flag


elif [ $wifi_wlan1_b == 1 ];then
        flag=wlan1
        update_wirelessinterface_private_wifi_2G $flag


elif [ $wifi_wlan2_b == 1 ];then
        flag=wlan2
        update_wirelessinterface_private_wifi_2G $flag


elif [ $wifi_wlan3_b == 1 ];then
        flag=wlan3
        update_wirelessinterface_private_wifi_2G $flag
fi


############################# public wifi for 2g , private and xfinity-wifi for 5G ##############################
if [ "$flag" == "wlan0" ] ; then
	if [ $wifi_wlan1 -ge 13 ] && [ $wifi_wlan1 -le 14 ]; then
		flag_2g=wlan1
		private_5g=wlan2
		public_5g=wlan3
		update_wirelessinterface_public_wifi_2G $flag_2g
		update_wirelessinterface_private_wifi_5G $private_5g
		update_wirelessinterface_public_wifi_5G $public_5g
	elif [ $wifi_wlan2 -ge 13 ] && [ $wifi_wlan2 -le 14 ]; then
		flag_2g=wlan2
		private_5g=wlan1
		public_5g=wlan3
		update_wirelessinterface_public_wifi_2G $flag_2g
		update_wirelessinterface_private_wifi_5G $private_5g
		update_wirelessinterface_public_wifi_5G $public_5g
	elif [ $wifi_wlan2 -ge 13 ] && [ $wifi_wlan2 -le 14 ]; then
		flag_2g=wlan2
		private_5g=wlan1
		public_5g=wlan3
		update_wirelessinterface_public_wifi_2G $flag_2g
		update_wirelessinterface_private_wifi_5G $private_5g
		update_wirelessinterface_public_wifi_5G $public_5g
	fi

elif [ "$flag" == "wlan1" ] ; then
	if [ $wifi_wlan0 -ge 13 ] && [ $wifi_wlan0 -le 14 ]; then
		flag_2g=wlan0
		private_5g=wlan2
		public_5g=wlan3
		update_wirelessinterface_public_wifi_2G $flag_2g
		update_wirelessinterface_private_wifi_5G $private_5g
		update_wirelessinterface_public_wifi_5G $public_5g
	elif [ $wifi_wlan2 -ge 13 ] && [ $wifi_wlan2 -le 14 ]; then
		flag_2g=wlan2
		private_5g=wlan0
		public_5g=wlan3
		update_wirelessinterface_public_wifi_2G $flag_2g
		update_wirelessinterface_private_wifi_5G $private_5g
		update_wirelessinterface_public_wifi_5G $public_5g
	elif [ $wifi_wlan3 -ge 13 ] && [ $wifi_wlan3 -le 14 ]; then
		flag_2g=wlan3
		private_5g=wlan0
		public_5g=wlan2
		update_wirelessinterface_public_wifi_2G $flag_2g
		update_wirelessinterface_private_wifi_5G $private_5g
		update_wirelessinterface_public_wifi_5G $public_5g
	fi


elif [ "$flag" == "wlan2" ] ; then
	if [ $wifi_wlan0 -ge 13 ] && [ $wifi_wlan0 -le 14 ]; then
		flag_2g=wlan0
		private_5g=wlan1
		public_5g=wlan3
		update_wirelessinterface_public_wifi_2G $flag_2g
		update_wirelessinterface_private_wifi_5G $private_5g
		update_wirelessinterface_public_wifi_5G $public_5g
	elif [ $wifi_wlan1 -ge 13 ] && [ $wifi_wlan1 -le 14 ]; then
		flag_2g=wlan1
		private_5g=wlan0
		public_5g=wlan3
		update_wirelessinterface_public_wifi_2G $flag_2g
		update_wirelessinterface_private_wifi_5G $private_5g
		update_wirelessinterface_public_wifi_5G $public_5g
	elif [ $wifi_wlan3 -ge 13 ] && [ $wifi_wlan3 -le 14 ]; then
		flag_2g=wlan3
		private_5g=wlan1
		public_5g=wlan0
		update_wirelessinterface_public_wifi_2G $flag_2g
		update_wirelessinterface_private_wifi_5G $private_5g
		update_wirelessinterface_public_wifi_5G $public_5g
	fi

elif [ "$flag" == "wlan3" ] ; then
        if [ $wifi_wlan0 -ge 13 ] && [ $wifi_wlan0 -le 14 ]; then
                flag_2g=wlan0
                private_5g=wlan1
                public_5g=wlan2
                update_wirelessinterface_public_wifi_2G $flag_2g
                update_wirelessinterface_private_wifi_5G $private_5g
                update_wirelessinterface_public_wifi_5G $public_5g
        elif [ $wifi_wlan1 -ge 13 ] && [ $wifi_wlan1 -le 14 ]; then
                flag_2g=wlan1
                private_5g=wlan0
                public_5g=wlan2
                update_wirelessinterface_public_wifi_2G $flag_2g
                update_wirelessinterface_private_wifi_5G $private_5g
                update_wirelessinterface_public_wifi_5G $public_5g
        elif [ $wifi_wlan2 -ge 13 ] && [ $wifi_wlan2 -le 14 ]; then
                flag_2g=wlan2
                private_5g=wlan1
                public_5g=wlan0
                update_wirelessinterface_public_wifi_2G $flag_2g
                update_wirelessinterface_private_wifi_5G $private_5g
                update_wirelessinterface_public_wifi_5G $public_5g
        fi

fi

else
	echo " No wireless Interfaces"
fi


#knowning the current status of private and public wifi
if [ ! -f "/var/Get5gssidEnable.txt" ]; then
	echo "1" > /var/Get5gssidEnable.txt
fi                                                               
if [ ! -f "/var/Get2gssidEnable.txt" ]; then
	echo "1" > /var/Get2gssidEnable.txt                                  
fi                                                               
if [ ! -f "/var/GetPub5gssidEnable.txt" ]; then
	echo "1" > /var/GetPub5gssidEnable.txt                                                       
fi                                                               
if [ ! -f "/var/GetPub2gssidEnable.txt" ]; then
	echo "1" > /var/GetPub2gssidEnable.txt
fi                                                               
if [ ! -f "/var/Get2gRadioEnable.txt" ]; then
	echo "1" > /var/Get2gRadioEnable.txt                                                       
fi                                                               
if [ ! -f "/var/Get5gRadioEnable.txt" ]; then
	echo "1" > /var/Get5gRadioEnable.txt
fi                                                               


Disabling_XfinityWiFi ()
{
	hostapd_cli -p /var/run/hostapd$2 -i $1 SET ignore_broadcast_ssid 1
	hostapd_cli -p /var/run/hostapd$2 -i $1 DISABLE
	hostapd_cli -p /var/run/hostapd$2 -i $1 ENABLE
}

sleep 3  #for xfinity-wifi feature
if [ "$HOTSPOT_ENABLE" -eq 0 ]; then
        wifi_oldinterface=`cat /nvram/hostapd4.conf | grep interface= | head -n1 | cut -d '=' -f2`
        wifi_count_2g=`ifconfig $wifi_oldinterface | grep $wifi_oldinterface | wc -l`
	Disabling_XfinityWiFi $wifi_oldinterface 4
        if [ "$wifi_count_2g" == 1 ]; then
                ifconfig $wifi_oldinterface down 
        fi 
        wifi_oldinterface=`cat /nvram/hostapd5.conf | grep interface= | head -n1 | cut -d '=' -f2`
        wifi_count_5g=`ifconfig $wifi_oldinterface | grep $wifi_oldinterface | wc -l`
	Disabling_XfinityWiFi $wifi_oldinterface 5
        if [ "$wifi_count_5g" == 1 ]; then 
                ifconfig $wifi_oldinterface down
        fi 
echo "0" > /var/GetPub5gssidEnable.txt                                                                                       
echo "0" > /var/GetPub2gssidEnable.txt
fi

 
echo $wifi > /tmp/wireless_interface_count
