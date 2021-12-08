FILESEXTRAPATHS_prepend := "${THISDIR}/linux-raspberrypi:"
 
KMETA = "kernel-meta"
 
SRC_URI = " \
     git://github.com/android-rpi/kernel_arpi/;branch=arpi-5.10;name=machine;protocol=https \
     git://git.yoctoproject.org/yocto-kernel-cache;type=kmeta;name=meta;branch=${LINUX_RPI_KMETA_BRANCH};destsuffix=${KMETA} \
	 "

require android-raspberrypi.inc

SRC_URI_remove = "file://rpi-kernel-misc.cfg"
