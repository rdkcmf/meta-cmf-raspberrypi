FILESEXTRAPATHS_prepend := "${THISDIR}/linux-raspberrypi:"
 
KMETA = "kernel-meta"
 
SRC_URI = " \
     git://github.com/android-rpi/kernel_arpi/;branch=arpi-5.10;name=machine;protocol=https \
     git://git.yoctoproject.org/yocto-kernel-cache;type=kmeta;name=meta;branch=${LINUX_RPI_KMETA_BRANCH};destsuffix=${KMETA} \
	 "
require recipes-kernel/linux/linux-raspberrypi.inc
DESCRIPTION = "Android Kernel for Raspberry Pi"
LIC_FILES_CHKSUM = "file://COPYING;md5=6bc538ed5bd9a7fc9398086aedcd7e46"
PV = "5.10.82"

SRC_URI_remove = "file://rpi-kernel-misc.cfg"
