#bin/sh
. /etc/device.properties
##--------------------------------------------------------------------------------------------------
# Partition Creation for bank1 and storage area
#--------------------------------------------------------------------------------------------------
partition_check_name=`fdisk /dev/mmcblk0 -l | grep mmcblk0p* | tail -2 | tr -s ' ' | cut -d ' ' -f1 | tail -1`
echo "Checking available partition for bank switch and image upgrade... "
# To Create P3 and P4 partition if not available
if [ "$partition_check_name" = "/dev/mmcblk0p2" ];
then
        if [ `fdisk -l | grep -c "CHS"`  == "1" ]; then
		bank1_partition=`fdisk /dev/mmcblk0 -l | grep mmcblk0p* | tail -2 | tr -s ' ' | cut -d ' ' -f5 | tail -1`
		elif [ `fdisk -l | grep -c "CHS"` == "0" ] && [ `cat /version.txt | grep -c "dunfell"` != "0"  ]; then
		 bank1_partition=`fdisk /dev/mmcblk0 -l | grep mmcblk0p* | tail -2 | tr -s ' ' | cut -d ' ' -f3 | tail -1`
        else
		bank1_partition=`fdisk /dev/mmcblk0 -ul | grep mmcblk0p* | tail -2 | tr -s ' ' | cut -d ' ' -f3 | tail -1`
        fi
		
		bank_offset=1
# Give Partition offset size in sector based.
#    1 sector = 512
# for Ex : Allocating 1GB for partition
#    2GB = ( 1024 * 1024 * 1024 ) * 2
#    sector size for 1GB = (1024*1024*1024)*2/512 = 4194304 sectors
#    Finally need to give partition size offset is 4194304 for 1GB partiton allocation.
        size_offset=$PART_SIZE_OFFSET
        bank1_start=$((bank1_partition+bank_offset))
        bank1_end=$((bank1_start+size_offset))
        echo "Creating Bank1 rootfs partition mmc0blkp3..."
if [ `fdisk -l | grep -c "CHS"` == "1" ]; then
        echo -e "\nn\np\n3\n$((bank1_start))\n$((bank1_end))\np\nw" | fdisk /dev/mmcblk0
        storage_partition=`fdisk /dev/mmcblk0 -l | grep mmcblk0p* | tail -2 | tr -s ' ' | cut -d ' ' -f5 | tail -1`
elif [ `fdisk -l | grep -c "CHS"` == "0" ] && [ `cat /version.txt | grep -c "dunfell"`  != "0" ]; then
       	echo -e "\nn\np\n3\n$((bank1_start))\n$((bank1_end))\np\nw" | fdisk /dev/mmcblk0
        storage_partition=`fdisk /dev/mmcblk0 -l | grep mmcblk0p* | tail -2 | tr -s ' ' | cut -d ' ' -f3 | tail -1`
else		
        echo -e "\nu\nn\np\n3\n$((bank1_start))\n$((bank1_end))\np\nw" | fdisk /dev/mmcblk0
        storage_partition=`fdisk /dev/mmcblk0 -ul | grep mmcblk0p* | tail -2 | tr -s ' ' | cut -d ' ' -f3 | tail -1`
  fi
        storage_offset=1
        size_offset=$PART_SIZE_OFFSET
        storage_start=$((storage_partition+storage_offset))
        storage_end=$((storage_start+size_offset))
        echo "Creating Storage partition mmc0blkp4..."
	if [ `cat /version.txt | grep -c "dunfell"` != "0" ]; then
		echo -e "\nn\np\n$((storage_start))\n$((storage_end))\np\nw" | fdisk /dev/mmcblk0
	 else
                echo -e "\nu\nn\np\n$((storage_start))\n$((storage_end))\np\nw" | fdisk /dev/mmcblk0
         fi	
	reboot -f
else
# To Create Storage partition p4  if rootfs partition p3 is available
    echo "Bank1 rootfs partition mmcblk0p3 is available"
    if [ "$partition_check_name" = "/dev/mmcblk0p3" ]
    then
	
	if [ `fdisk -l | grep -c "CHS"`   == "1"  ]; then
	
	storage_partition=`fdisk /dev/mmcblk0 -l | grep mmcblk0p* | tail -2 | tr -s ' ' | cut -d ' ' -f5 | tail -1`
	elif [ `fdisk -l | grep -c "CHS"` == "0" ] && [ `cat /version.txt | grep -c "dunfell"`  != "0" ]; then
	 
	storage_partition=`fdisk /dev/mmcblk0 -l | grep mmcblk0p* | tail -2 | tr -s ' ' | cut -d ' ' -f3 | tail -1`
     else	
        storage_partition=`fdisk /dev/mmcblk0 -ul | grep mmcblk0p* | tail -2 | tr -s ' ' | cut -d ' ' -f3 | tail -1`
      fi
	    storage_offset=1
        size_offset=$PART_SIZE_OFFSET
        storage_start=$((storage_partition+storage_offset))
        storage_end=$((storage_start+size_offset))
        echo "Creating Storage partition mmc0blkp4..."
	if [ `cat /version.txt | grep -c "dunfell"`  != "0" ]; then
            echo -e "\nn\np\n$((storage_start))\n$((storage_end))\np\nw" | fdisk /dev/mmcblk0
	else
            echo -e "\nu\nn\np\n$((storage_start))\n$((storage_end))\np\nw" | fdisk /dev/mmcblk0
        fi
          reboot -f
    else
        echo "storage partition mmcblk0p4 is available"
    fi
fi
