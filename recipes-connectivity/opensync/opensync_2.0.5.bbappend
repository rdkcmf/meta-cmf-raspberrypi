FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

VENDOR_URI = "git://git@github.com/rdkcentral/opensync-vendor-rdk-rpi.git;protocol=${CMF_GIT_PROTOCOL};branch=main;name=vendor;destsuffix=git/vendor/rpi"
VENDOR_URI += "file://config-rdk-multi-psk-disable.patch;patchdir=${WORKDIR}/git/"
VENDOR_URI += "file://service.patch;patchdir=${WORKDIR}/git/"
VENDOR_URI += "file://opensync.service"

DEPENDS_append = " rdk-logger hal-wifi-generic"

RDK_CFLAGS += " -D_PLATFORM_RASPBERRYPI_"
