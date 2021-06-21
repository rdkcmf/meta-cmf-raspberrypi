BBMASK .= "|meta-rdk/recipes-support/base64"

BBMASK .= "|meta-rdk/recipes-common/rdkversion/"
BBMASK .= "|meta-cmf/recipes-common/rdkversion/"

BBMASK .= "|meta-rdk/recipes-common/sys_mon_tools/cpuprocanalyzer_git.bb"
BBMASK .= "|meta-cmf/recipes-common/sys_mon_tools/cpuprocanalyzer_git.bbappend"

BBMASK .= "|meta-rdk-broadband/recipes-ccsp/ccsp/ccsp-moca.bb"
BBMASK .= "|meta-cmf-broadband/recipes-ccsp/ccsp/ccsp-moca.bbappend"

BBMASK .= "|meta-cmf-raspberrypi/recipes-connectivity/bluetooth/"
BBMASK .= "|meta-cmf-raspberrypi/recipes-extended/aamp/"
BBMASK .= "|meta-cmf-raspberrypi/recipes-extended/appmanager/"
BBMASK .= "|meta-cmf-raspberrypi/recipes-extended/gstqamtunersrc/"
BBMASK .= "|meta-cmf-raspberrypi/recipes-extended/gst-plugins-playersinkbin/"
BBMASK .= "|meta-cmf-raspberrypi/recipes-extended/devicesettings/"
BBMASK .= "|meta-cmf-raspberrypi/recipes-extended/rdkapps/"
BBMASK .= "|meta-cmf-raspberrypi/recipes-extended/iarmmgrs/"
BBMASK .= "|meta-cmf-raspberrypi/recipes-extended/networkmgr/"
BBMASK .= "|meta-cmf-raspberrypi/recipes-extended/rdkservices/"
BBMASK .= "|meta-cmf-raspberrypi/recipes-extended/rms/"
BBMASK .= "|meta-cmf-raspberrypi/recipes-extended/tdkc/"
BBMASK .= "|meta-cmf-raspberrypi/recipes-graphics/"
BBMASK .= "|meta-cmf-raspberrypi/recipes-multimedia/"
BBMASK .= "|meta-cmf-raspberrypi/recipes-oem/mfrlibs/"
BBMASK .= "|meta-cmf-raspberrypi/recipes-wpe/"

BBMASK_append_dunfell .= "|meta-cmf-raspberrypi/recipes-bsp/bootfiles/bcm2835-bootfiles.bbappend"
