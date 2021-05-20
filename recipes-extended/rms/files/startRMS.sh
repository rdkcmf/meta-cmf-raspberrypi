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
                            
RMS_RUN_DIR=/usr/local/rms/bin               
CONF_FILE=rms.conf                  
                                                     
#go to the RMS working directory           
cd $RMS_RUN_DIR                                      
                                          
#Load RMS Configuration file                    
if [ ! -f $CONF_FILE ]; then                              
        echo "rms config file is not found"
else                                     
        . $CONF_FILE >/dev/null 2>&1                      
                                                
        if [ -z "$RRSIP" ] || [ -z "$RRSPORT" ]; then
                echo "invalid rrs ip/port"                
        elif [ -z "$ROOMID" ]; then             
                echo "invalid room id"                                             
        else                                                                       
                break                                     
        fi                  
                                                                                   
        echo "config loaded"                             
fi                 

sleep 5

curl "http://127.0.0.1:8080/setstream&width=$WIDTH&height=$HEIGHT&"

#Run RDKCmediaserver in background
./rdkcmediaserver ../config/config.lua &

#use RRS details                                
WRTCCMD="startwebrtc rrsport=$RRSPORT rrs=$RRSIP rrsOverSsl=$RRSSSL roomid=$ROOMID"
echo "RMS ready, sending command: $WRTCCMD"               
WRTCCMD=$WRTCCMD                                                                   
                                                          
while :                                         
do          
	sleep 5
                                                                       
        retval="$(echo $WRTCCMD | nc -w 1 127.0.0.1 1222)"
                            
        if  echo "$retval" | grep -q "FAIL"  ; then                             
                echo "webrtc Command Failed"
        else
                echo "webrtc command Successed"
		break                                
        fi                                 

done 
