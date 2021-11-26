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

##Added workaround fix for getting ip for lan clients

#Getting the Ethernet interface count
if_count=`ifconfig -a | grep eth | wc -l`
echo "if_count : $if_count"
#if it count is 1, we don't need to check the below cases because that's default ethernet interface.
if [ $if_count == 1 ]; then
	ifconfig eth0 down
	ip link set dev eth0 name erouter0
	ifconfig erouter0 up
	exit 0
fi

#Getting the Model Name of the board
Model_Name=`cat /proc/device-tree/model | cut -d ' ' -f3-6`
if [ "$Model_Name" = "3 Model B Plus" ]; then
echo "These fix is required for 3B+ Model Board"	
tem=`ethtool --show-eee eth0 | wc -l`
echo "tem eth0:$tem"
if [ $tem == 0 ]; then
ifconfig eth1 down
ifconfig eth0 down
ip link set eth1 name erouter0
ip link set eth0 name eth1
ifconfig eth1 up 
if [ ! -f /tmp/OS_WANMANAGER_ENABLED ]; then
ifconfig erouter0 up
fi
fi

tem1=`ethtool --show-eee eth1 | wc -l`
echo "tem1 eth1:$tem1"
if [ $tem1 == 0 ]; then
echo "Invalid eth1 interface names"
else
ifconfig eth1 down
ifconfig eth0 down
ip link set eth0 name eth1
ip link set eth1 name erouter0
ifconfig eth1 up 
if [ ! -f /tmp/OS_WANMANAGER_ENABLED ]; then
ifconfig erouter0 up
fi
fi
else
echo "These fix is not required for this model board"
fi
