require recipes-core/images/rdk-generic-hybrid-wpe-image.bb
require recipes-core/images/add-non-root-user-group.inc

# Use DTV Reference Application
IMAGE_INSTALL_append = " dtvapp"

IMAGE_INSTALL_append = " \
   gstqamtunersrc \
   hdhomerun \
   rdkapps \
   parodus \
   tr69hostif \
   tr69agent \
"

IMAGE_INSTALL_remove = " \
    westeros-init \
    wpe-webkit-init \
"
