# Note: This feature is for developers ONLY.
# Please do not forget to set BB_ENV_EXTRAWHITE before
# launching the yocto build.
# `export BB_ENV_EXTRAWHITE="${BB_ENV_EXTRAWHITE} RDK_ROOT_PATH"`
#
INHERIT += "externalsrc"

EXTERNALSRC_pn-hal-dhcpv4c-generic = "${@'${RDK_ROOT_PATH}/rdkb/components/opensource/ccsp/hal/source/dhcpv4c' if (os.path.isdir('${RDK_ROOT_PATH}/rdkb/components/opensource/ccsp/hal/source/dhcpv4c/devices_rpi')) else ''}"
EXTERNALSRC_pn-hal-ethsw-generic = "${@'${RDK_ROOT_PATH}/rdkb/components/opensource/ccsp/hal/source/ethsw' if (os.path.isdir('${RDK_ROOT_PATH}/rdkb/components/opensource/ccsp/hal/source/ethsw/devices_rpi')) else ''}"
EXTERNALSRC_pn-hal-fwupgrade = "${@'${RDK_ROOT_PATH}/rdkb/devices/raspberrypi/hal/source/fwupgrade' if (os.path.isdir('${RDK_ROOT_PATH}/rdkb/devices/raspberrypi/hal/source/fwupgrade')) else ''}"
EXTERNALSRC_pn-hal-platform-generic = "${@'${RDK_ROOT_PATH}/rdkb/components/opensource/ccsp/hal/source/platform' if (os.path.isdir('${RDK_ROOT_PATH}/rdkb/components/opensource/ccsp/hal/source/platform/devices_rpi')) else ''}"
EXTERNALSRC_pn-hal-wifi-generic = "${@'${RDK_ROOT_PATH}/rdkb/components/opensource/ccsp/hal/source/wifi' if (os.path.isdir('${RDK_ROOT_PATH}/rdkb/components/opensource/ccsp/hal/source/wifi/devices_rpi')) else ''}"
EXTERNALSRC_pn-sysint = "${@'${RDK_ROOT_PATH}/rdk/components/opensource/sysint/devicerpi' if (("rpi" in d.getVar('MACHINEOVERRIDES', True)) and (os.path.isdir('${RDK_ROOT_PATH}/rdk/components/opensource/sysint'))) else ''}"
EXTERNALSRC_pn-westeros-sink = "${@'${RDK_ROOT_PATH}/components/opensource/westeros' if (os.path.isdir('${RDK_ROOT_PATH}/components/opensource/westeros')) else ''}"
