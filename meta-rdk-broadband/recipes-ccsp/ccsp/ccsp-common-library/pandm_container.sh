#!/bin/sh
##########################################################################
# If not stated otherwise in this file or this component's Licenses.txt
# file the following copyright and licenses apply:
#
# Copyright 2019 RDK Management
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
#


cp /bin/grep /container/CCSPPANDM/rootfs/usr/bin
cp -rf /usr/lib/xtables /container/CCSPPANDM/rootfs/usr/lib
mkdir -p /container/CCSPPANDM/rootfs/nvram
cp -r /container/PSMSSP/rootfs/nvram/* /nvram/
cp -rf /nvram/* /container/CCSPPANDM/rootfs/nvram/
mkdir -p /container/CCSPPANDM/rootfs/fss/
mkdir -p /container/CCSPPANDM/rootfs/fss/gw
mkdir -p /container/CCSPPANDM/rootfs/fss/gw/usr
mkdir -p /container/CCSPPANDM/rootfs/fss/gw/usr/sbin
cp /sbin/ip /container/CCSPPANDM/rootfs/fss/gw/usr/sbin/ip
cp /bin/ps /container/CCSPPANDM/rootfs/usr/bin


sed -i  '/exec/c\#exec 3>&1 4>&2 >>$CONSOLEFILE 2>&1' /etc/utopia/service.d/log_capture_path.sh
cp /etc/utopia/service.d/log_capture_path.sh /container/CCSPPANDM/rootfs/etc/utopia/service.d/log_capture_path.sh
cp /sbin/ifconfig /container/CCSPPANDM/rootfs/usr/bin/
cp /usr/sbin/ip6tables /container/CCSPPANDM/rootfs/usr/bin/
cp -rf /var/* /container/CCSPPANDM/rootfs/var/
cp /usr/sbin/iptables /container/CCSPPANDM/rootfs/usr/bin/
cp /sbin/ip  /container/CCSPPANDM/rootfs/usr/bin/
cp /sbin/vconfig /container/CCSPPANDM/rootfs/usr/bin/

if grep -q sleep /container/CCSPPANDM/launcher/CcspPandMSsp.sh; then
    echo "pandm:startup lxc-attach is already present"
else
    sed  -i '/lxc-execute/s/$/ \&\n\t\tsleep 45\n\t\t\/usr\/bin\/lxc-attach -n CCSPPANDM  -f \/container\/CCSPPANDM\/conf\/lxc.conf -u 706 -g 706 -- \/usr\/bin\/CcspPandMSsp -subsys eRT./' /container/CCSPPANDM/launcher/CcspPandMSsp.sh
fi




chown pandm:pandm /usr/bin/gw_prov_utopia
chown -R pandm:pandm /container/CCSPPANDM/rootfs


