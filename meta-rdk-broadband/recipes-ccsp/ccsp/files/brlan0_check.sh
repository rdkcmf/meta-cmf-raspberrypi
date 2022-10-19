#!/bin/sh
##########################################################################
# If not stated otherwise in this file or this component's Licenses.txt
# file the following copyright and licenses apply:
#
# Copyright 2021 RDK Management
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
##########################################################################
sleep 30
### Temp fix for brlan0 issue

eth0_to_eth1_rename=0
#Getting the Model Name of the board
Model_Name=`cat /proc/device-tree/model`
while [ 1 ]
do
LanMode=`dmcli eRT getv Device.X_CISCO_COM_DeviceControl.LanManagementEntry.1.LanMode | grep value | cut -d ':' -f3 | cut -d ' ' -f2 | tr -d '\n'`
if [ "$LanMode" = "router" ]; then	
if [ "$Model_Name" = "FriendlyARM NanoPi R1" ] && [ $eth0_to_eth1_rename = 0 ]; then
    echo "This fix is required for FriendlyARM NanoPi R1 Model Board"
    if [ -d /sys/class/net/eth0 ]; then
        ip link set dev eth0 name eth1
        eth0_to_eth1_rename=1
        ifconfig eth1 up
    fi
fi
brlan0_status=`ifconfig | grep brlan0 | wc -l`
brlan0_ip=`ifconfig brlan0 | grep "inet addr" | cut -d ':' -f2 | cut -d ' ' -f1  | wc -l`
Interface_2g=`cat /nvram/hostapd0.conf  | grep interface= | cut -d '=' -f2 | head -n1`
Interface_5g=`cat /nvram/hostapd1.conf  | grep interface= | cut -d '=' -f2 | head -n1`
brlan0_2g=`brctl show brlan0 | grep $Interface_2g | wc -l`
brlan0_5g=`brctl show brlan0 | grep $Interface_5g | wc -l`
#echo "brlan0_process value is $brlan0_status and $brlan0_ip, $Interface_2g , $Interface_5g , $brlan0_2g , $brlan0_5g"
if [ $brlan0_status = 0 ] || [ $brlan0_ip = 0 ] || [ $brlan0_2g = 0 ] || [ $brlan0_5g = 0 ]; then
      gateway_ip=`cat /var/dnsmasq.conf  | grep dhcp-range= | cut -d '=' -f2 | cut -d ',' -f1 | cut -d '.' -f1-3`	
      ifconfig brlan0 $gateway_ip.1 up
      brctl addif brlan0 $Interface_2g
      brctl addif brlan0 $Interface_5g
fi
fi
sleep 10
done
