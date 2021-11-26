#!/bin/sh
##########################################################################
# If not stated otherwise in this file or this component's Licenses.txt
# file the following copyright and licenses apply:
#
# Copyright 2016 RDK Management
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

#Set environment

# Need to modify this changes only for the wifi
#if [ "`ifconfig wlan0 | grep "inet addr" | cut -c11-19`" != "inet addr" ] ; then
#        systemctl restart wpa_supplicant
#        udhcpc -i wlan0
#fi

#Load v4l2
modprobe bcm2835-v4l2

#Run mediastreamer binary in backgroud
export LD_PRELOAD=/usr/lib/libwayland-client.so.0:/usr/lib/libwayland-egl.so:/usr/lib/libopenmaxil.so

#Run mediastreamer binary in background
# 1. To validate streaming with v4l2 need to give "mediastreamer v4l2src &"
# 2. To validate streaming with libcamera need to give "mediastreamer libcamerasrc &"
# If we change 1 and 2, need to reboot the target and validate streaming.

mediastreamer v4l2src &

