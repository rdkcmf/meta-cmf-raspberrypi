FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI_append_raspberrypi4-64 = " file://rtremote_lose_precision.patch;striplevel=1"
