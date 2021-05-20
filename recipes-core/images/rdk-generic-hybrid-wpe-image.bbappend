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

# Space is required for firmware upgrade
IMAGE_ROOTFS_EXTRA_SPACE = "204800"