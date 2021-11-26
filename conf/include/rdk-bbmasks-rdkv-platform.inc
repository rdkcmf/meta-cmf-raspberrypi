BBMASK .= "|meta-rdk/recipes-common/rdk-oss-ssa/"
BBMASK .= "|meta-rdk/recipes-support/base64"

BBMASK .= "|openembedded-core/meta/recipes-multimedia/gstreamer/gstreamer1.0-plugins-ugly_1.8.3.bb"
BBMASK_append_morty .= "|meta-raspberrypi/recipes-multimedia/gstreamer/gstreamer1.0-omx*"

BBMASK .= "|meta-cmf-raspberrypi/recipes-extended/rms/"
BBMASK .= "|meta-cmf-raspberrypi/recipes-extended/tdkb/"
BBMASK .= "|meta-cmf-raspberrypi/recipes-extended/tdkc/"
BBMASK .= "|meta-cmf-raspberrypi/recipes-multimedia/cvr/"
BBMASK .= "|meta-cmf-raspberrypi/recipes-multimedia/mediastreamer/"

# this bbappend holds old revision and checksum values which is not applicable for dunfell builds
# as meta-raspberrypi has the latest revision and it's checksum values
BBMASK_append_dunfell = "|meta-cmf-raspberrypi/recipes-bsp/bootfiles/bcm2835-bootfiles.bbappend"
BBMASK_append_morty .= "|meta-cmf-raspberrypi/recipes-bsp/u-boot/"
