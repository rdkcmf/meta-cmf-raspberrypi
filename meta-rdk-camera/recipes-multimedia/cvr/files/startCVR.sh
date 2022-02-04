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

CONF_FILE=/usr/local/cvr/cvr.conf

#Load CVR Configuration file
if [ ! -f $CONF_FILE ]; then
        echo "cvr config file is not found"
else
        . $CONF_FILE >/dev/null 2>&1

	if [ -z "$STREAM_NAME" ] || [ -z "$AWS_DEFAULT_REGION" ] || [ -z "$IOT_GET_CREDENTIAL_ENDPOINT" ] || [ -z "$CERT_PATH" ] ||\
           [ -z "$PRIVATE_KEY_PATH" ] || [ -z "$ROLE_ALIAS" ] || [ -z "$CA_CERT_PATH" ]; then
                echo "invalid AWS credential"                                                                                           
        else                                                                                                                            
                break                                                                                                                   
        fi                                                                                                                              
                                                                                                                                        
        echo "config loaded"                                                                                                            
fi                                                                        
 
#AWS credential
export STREAM_NAME=$STREAM_NAME                                                                                                         
                                                                                                                                        
export AWS_DEFAULT_REGION=$AWS_DEFAULT_REGION                                                                                           
                                                                                                                                        
export IOT_GET_CREDENTIAL_ENDPOINT=$IOT_GET_CREDENTIAL_ENDPOINT                                                                         
                                                               
export CERT_PATH=$CERT_PATH                                                                                                             
                                                                                                                                        
export PRIVATE_KEY_PATH=$PRIVATE_KEY_PATH                                                                                               
                                                                                                                                        
export ROLE_ALIAS=$ROLE_ALIAS                                                                                                           
                                                                                                                                        
export CA_CERT_PATH=$CA_CERT_PATH                                                                                                       
                                                                                                                                        
                                                                                                                                        
#Run CVR in background                                                                                                      
cvr_daemon_kvs2 & 
