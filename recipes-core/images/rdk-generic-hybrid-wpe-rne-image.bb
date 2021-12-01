require recipes-core/images/rdk-generic-hybrid-wpe-image.bb
require recipes-core/images/sdk-common.inc
require recipes-core/images/add-non-root-user-group.inc

IMAGE_FEATURES += "firebolt"

IMAGE_INSTALL_append = " \
   gstqamtunersrc \
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
