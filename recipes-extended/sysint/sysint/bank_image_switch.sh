#--------------------------------------------------------------------------------------------------
# Identify active bank ( either bank 0 or bank 1 ) or ( mmcblk0p2 or mmcblk0p3 )
#--------------------------------------------------------------------------------------------------

activeBank=`sed -e "s/.*root=//g" /proc/cmdline | cut -d ' ' -f1`
echo "Active bank partition is $activeBank"

bank1_partition_name=`fdisk /dev/mmcblk0 -l | tail -2 | cut -d' ' -f1 | head -n1`
storage_block_name=`fdisk /dev/mmcblk0 -l | tail -2 | cut -d' ' -f1 | tail -1`

mkdir -p /extblock
mount $storage_block_name /extblock

mkdir -p /extblock/bank0_linux

mount /dev/mmcblk0p1 /extblock/bank0_linux

if [ "$activeBank" = "$bank1_partition_name" ];
then

    passiveBank=/dev/mmcblk0p2;

    rm -rf /extblock/bank0_linux/*

    cp -R /extblock/data_bkup_linux_bank0/* /extblock/bank0_linux/

    # change cmdline.txt for bank0 linux to partition p2 or mmcblk0p2 which has to be active bank after reboot
    sed -i -e "s|${activeBank}|${passiveBank}|g" /extblock/bank0_linux/cmdline.txt

else

    passiveBank=$bank1_partition_name;

    rm -rf /extblock/bank0_linux/*

    cp -R /extblock/data_bkup_linux_bank1/* /extblock/bank0_linux/

    # change cmdline.txt for bank0 linux to partition p2 or mmcblk0p2 which has to be active bank after reboot
    sed -i -e "s|${activeBank}|${passiveBank}|g" /extblock/bank0_linux/cmdline.txt

fi

umount /extblock/bank0_linux

rm -rf /extblock/bank0_linux


umount /extblock

echo "Rebooting with bank switch ...."

reboot -f
    
