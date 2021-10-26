LINUX_VERSION ?= "5.10.52"
LINUX_RPI_BRANCH ?= "rpi-5.10.y"
LINUX_RPI_KMETA_BRANCH ?= "yocto-5.10"

SRCREV_machine = "2697f7403187bb2bb61cc716f33ee9f6cfb9af7c"
SRCREV_meta = "dbe03fa9005d388617aca3bcfb1b06ba35d49215"

require linux-raspberrypi_5.10.52.inc

FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI += " file://powersave.cfg \
             file://android-drivers.cfg \
"
