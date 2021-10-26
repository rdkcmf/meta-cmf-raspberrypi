FILESEXTRAPATHS_prepend := "${THISDIR}/linux-raspberrypi:"

KMETA = "kernel-meta"

SRC_URI = " \
    git://github.com/raspberrypi/linux.git;protocol=https;name=machine;branch=${LINUX_RPI_BRANCH} \
    git://git.yoctoproject.org/yocto-kernel-cache;protocol=https;type=kmeta;name=meta;branch=${LINUX_RPI_KMETA_BRANCH};destsuffix=${KMETA} \
"
SRC_URI_remove = "file://rpi-kernel-misc.cfg"

require recipes-kernel/linux/linux-raspberrypi.inc

LIC_FILES_CHKSUM = "file://COPYING;md5=6bc538ed5bd9a7fc9398086aedcd7e46"

KERNEL_EXTRA_ARGS_append_rpi = " DTC_FLAGS='-@ -H epapr'"

KBUILD_DEFCONFIG_raspberrypi4-5.10 ?= "bcm2711_defconfig"
