#!/bin/sh

# If not stated otherwise in this file or this component's Licenses.txt file the
# following copyright and licenses apply:
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

. /etc/device.properties
. /etc/include.properties
. $RDK_PATH/utils.sh
. $RDK_PATH/getPartnerId.sh

SSL_CERT_FILE="/etc/ssl/certs/ca-certificates.crt"

get_hardware_mac()
{
    hw_mac=$(getEstbMacAddressWithoutColon)
    [ -z "$hw_mac" ] && [ -e "/tmp/.macAddress" ] && hw_mac=$(sed 's/://g' /tmp/.macAddress)
    echo "$hw_mac"
}

get_ImageName()
{
    image=$(grep "^imagename:$versionTag2" /version.txt | cut -d ":" -f 2)
    echo "$image"
}
parodus_start_up()
{

    HwMac=$(get_hardware_mac)

    if [ -z "$HwMac" ]; then
        echo "Failed to fetch macAddress. Exiting."
        # sleep 10 # add any more delay needed for a macAddress fetch retry (beyond the RestartSec=10s in parodus.service)
        exit 1
    fi

    local Interface

    if [ -z "${WIFI_INTERFACE}" ]; then
        echo "Model number is undefined"
    else
        Interface=${WIFI_INTERFACE}
    fi

    Image=$(get_ImageName)

    local Model
    if [ -z "${MODEL_NUM}" ]; then
        echo "Model number is undefined"
    else
        Model=${MODEL_NUM}
    fi


    echo "Starting parodus with arguments hw-mac=$HwMac webpa-ping-time=60 webpa-interface-used=$Interface --webpa-url=http://192.168.2.75:8080 --partner-id=comcast --force-ipv4 --fw-name=$Image --hw-model=$Model"

    /usr/bin/parodus --hw-mac=$HwMac --webpa-ping-time=60 --webpa-interface-used=$Interface --webpa-url=http://192.168.2.75:8080 --partner-id=comcast --webpa-backoff-max=9 --ssl-cert-path=$SSL_CERT_FILE --force-ipv4 &

    echo "Parodus command set.."
}

parodus_start_up
sleep 10

