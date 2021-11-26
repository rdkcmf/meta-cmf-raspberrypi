#!/bin/sh

. /etc/device.properties

export PATH=$PATH:/usr/bin:/bin:/usr/local/bin:/sbin:/usr/local/lighttpd/sbin:/usr/local/sbin
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/Qt/lib:/usr/local/lib


# input arguments
PROTO=$1
CLOUD_LOCATION=$2
DOWNLOAD_LOCATION=$3
UPGRADE_FILE=$4
REBOOT_FLAG=$5
PDRI_UPGRADE=$6


if [ ! $PROTO ];then echo "Missing the upgrade proto..!"; exit -2;fi
if [ ! $CLOUD_LOCATION ];then echo "Missing the cloud image location..!"; exit -2;fi
# pokuru if [ ! $DOWNLOAD_LOCATION ];then echo "Missing the local download image location..!"; exit -2;fi
if [ ! $UPGRADE_FILE ];then echo "Missing the image file..!"; exit -2;fi

echo "ckp202---------------"$UPGRADE_FILE
# Call RPI flashing utility
if [ -f /lib/rdk/rpi_sw_install.sh ]; then 
    echo "CKP !!!!!!!!! calling rpi_sw_install"
    #pokuru /usr/bin/rpi_sw_install $DOWNLOAD_LOCATION/$UPGRADE_FILE
   sh /lib/rdk/rpi_sw_install.sh
    echo "CKP !!!!!!!!! calling rpi_sw_install1"
    echo "proto is"$PROTO
    echo "cloud loc is"$CLOUD_LOCATION
    echo "upg file is"$DOWNLOAD_LOCATION
    echo "1" $1 
    echo "2" $2
    echo "3" $3 
    echo "4" $4 
    echo "5" $5
    echo "6" $6 
   sh /lib/rdk/rpi_sw_install1.sh $PROTO $CLOUD_LOCATION $DOWNLOAD_LOCATION
    exit $?
else
   echo "Error !!! Flashing utility /bin/rpi_sw_install not present !!!!"
   exit 1
fi
