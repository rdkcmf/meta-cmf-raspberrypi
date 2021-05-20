require recipes-core/images/rdk-generic-hybrid-wpe-image.bb

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
