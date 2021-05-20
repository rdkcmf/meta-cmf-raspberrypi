IMAGE_INSTALL_append = " \
   packagegroup-tdk \
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

PACKAGE_EXCLUDE_pn-rdk-generic-hybrid-westeros-wpe-tdk-image = "${@bb.utils.contains('DISTRO_FEATURES','ENABLE_IPK','packagegroup-tdk','',d)}"
