require recipes-core/images/rdk-generic-mediaclient-wpe-image.bb

IMAGE_INSTALL_append = " \
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
