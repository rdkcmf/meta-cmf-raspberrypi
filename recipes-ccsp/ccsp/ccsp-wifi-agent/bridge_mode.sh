#!/bin/sh

########################### FOR BRIDGE MODE SET UP ##############################

sleep 5

BRIDGE_MODE=`dmcli eRT getv Device.X_CISCO_COM_DeviceControl.LanManagementEntry.1.LanMode | grep value | cut -d ':' -f3 | cut -d ' ' -f2`
PRIVATE_WIFI_2G=`cat /nvram/hostapd0.conf | grep interface= | head -n1 | cut -d '=' -f2`
PRIVATE_WIFI_5G=`cat /nvram/hostapd1.conf | grep interface= | head -n1 | cut -d '=' -f2`
echo "BRIDGE MODE is $BRIDGE_MODE"
if [ "$BRIDGE_MODE" = "bridge-static" ] ; then
	sysevent set lan-stop
	ifconfig $PRIVATE_WIFI_2G down
	ifconfig $PRIVATE_WIFI_5G down 
	ps aux | grep hostapd1 | grep -v grep | awk '{print $1}' | xargs kill -9
	ps aux | grep hostapd0 | grep -v grep | awk '{print $1}' | xargs kill -9
else
	echo "Running in Router Mode"
fi

################# Make Persistent after reboot ################
        
        
######## SSID status
pri_2g=`cat /var/Get2gssidEnable.txt`
pri_5g=`cat /var/Get5gssidEnable.txt`
pub_2g=`cat /var/GetPub2gssidEnable.txt`
pub_5g=`cat /var/GetPub5gssidEnable.txt`
                                        
######## Radio Status
Rad_2g=`cat /var/Get2gRadioEnable.txt`
Rad_5g=`cat /var/Get5gRadioEnable.txt`
                                      
######### Current Wireless interfaces names
pri_wifi_2g=`grep interface= /nvram/hostapd0.conf | cut -d '=' -f2 | head -n 1`
pri_wifi_5g=`grep interface= /nvram/hostapd1.conf | cut -d '=' -f2 | head -n 1`
pub_wifi_2g=`grep interface= /nvram/hostapd4.conf | cut -d '=' -f2 | head -n 1`
pub_wifi_5g=`grep interface= /nvram/hostapd5.conf | cut -d '=' -f2 | head -n 1`
                                                                               
echo "wireless interface names : $pri_wifi_2g $pri_wifi_5g $pub_wifi_2g $pub_wifi_5g"
                                                                                     
Disable_WiFi ()
{              
         wifi_status=`ifconfig $1 | grep RUNNING  | wc -l`
         echo "wifi_status is $wifi_status $1"                  
         if  [ $wifi_status == 1 ] ; then
             ifconfig $1 down               
         fi    
}          

if [ $Rad_2g == 0 ] ; then                   
         Disable_WiFi $pri_wifi_2g 
         Disable_WiFi $pub_wifi_2g 
else                                            
        if [ $pub_2g == 0 ] ; then           
                Disable_WiFi $pub_wifi_2g 
        fi                                      
        if [ $pri_2g == 0 ] ; then           
                Disable_WiFi $pri_wifi_2g 
        fi                                                                     
fi                                                                             
                                                                               
if [ $Rad_5g == 0 ] ; then                   
         Disable_WiFi $pri_wifi_5g                                            
         Disable_WiFi $pub_wifi_5g 
else                                            
        if [ $pri_5g == 0 ] ; then           
                Disable_WiFi $pri_wifi_5g 
        fi                                      
        if [ $pub_5g == 0 ] ; then           
                Disable_WiFi $pub_wifi_5g
        fi                  
fi           

##Added workaround fix for LAN connection issue
ETH_INTERFACE=`ifconfig eth1 | grep eth1 | wc -l`                               
if [ $ETH_INTERFACE == 1 ] ; then
      ifconfig eth1 up
      brctl addif brlan0 eth1
fi   
