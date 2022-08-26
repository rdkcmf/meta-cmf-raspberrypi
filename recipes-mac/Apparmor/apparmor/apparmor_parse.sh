#!/bin/sh
Apparmor_blocklist="/opt/secure/Apparmor_blocklist"
PROFILES_DIR="/etc/apparmor.d/"
BINARY_PROFILES_DIR="/etc/apparmor.d/binaryprofiles/"
PARSER="/sbin/apparmor_parser"
SYSFS_AA_PATH="/sys/kernel/security/apparmor/profiles"
RDKLOGS="/opt/logs/startup_stdout_log.txt"

if [ -f /lib/rdk/t2Shared_api.sh ]; then
    source /lib/rdk/t2Shared_api.sh
fi
if [ ! -f $Apparmor_blocklist ]; then
     `/bin/cat > $Apparmor_blocklist << EOL
audiocapturemgr:disable
lighttpd:disable
irMgrMain:disable
default:disable
bluetoothd:disable
tr69hostif:disable
EOL`
fi
while read line; do
        mode=`echo $line | cut -d ":" -f 2`
        process=`echo $line | cut -d ":" -f 1`
        profile=`ls -ltr $PROFILES_DIR | grep $process | awk '{print $9}'`
        binary_profile=`ls -ltr $BINARY_PROFILES_DIR | grep $process | awk '{print $9}'`
        if [ "$binary_profile" == "" ]; then
              parseArgs="-rW $PROFILES_DIR/$profile"
        else
              parseArgs="-rB $BINARY_PROFILES_DIR/$binary_profile"
        fi
        if [ "$mode" == "enforce" ]; then
              $PARSER $parseArgs
        elif [ "$mode" == "complain" ]; then
              $PARSER -C $parseArgs
        elif [ "$mode" == "disable" ]; then
              echo "Apparmor profile:$profile is disabled"
        else
              echo "Apparmor profile:unknown $profile mode"
        fi
done<$Apparmor_blocklist
list=`cat $SYSFS_AA_PATH | grep complain | awk '{print $1}' | tr '\n'  ','`
cnt=`cat $SYSFS_AA_PATH | grep complain | wc -l
`
if [ ! -z "$list" ]; then
     echo "List of profiles in Apparmor-complain mode:$cnt : $list" >> $RDKLOGS
     t2ValNotify "APPARMOR_C_split:" "$cnt,$list"
fi
list=`cat $SYSFS_AA_PATH | grep enforce | awk '{print $1}' | tr '\n'  ','`
cnt=`cat $SYSFS_AA_PATH | grep enforce | wc -l`
if [ ! -z "$list" ]; then
     echo "List of profiles in Apparmor-enforce mode:$cnt : $list"  >> $RDKLOGS
     t2ValNotify "APPARMOR_E_split:" "$cnt,$list"
fi


