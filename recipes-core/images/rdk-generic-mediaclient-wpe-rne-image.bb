require recipes-core/images/rdk-generic-mediaclient-wpe-image.bb

IMAGE_FEATURES += "firebolt"

IMAGE_INSTALL_append = " \
   hdhomerun \
   rdkapps \
   westeros-sink \
"

IMAGE_INSTALL_remove = " \
    westeros-init \
    wpe-webkit-init \
"

RDEPENDS_packagegroup-rdk-broadcom-refsw_remove = "broadcom-refsw"
inherit rdk-image-sdk
