EXTRA_OECONF += " --enable-pi-build "

EXTRA_OECONF_remove += " ${@bb.utils.contains("DISTRO_FEATURES", "ipclient", " ${ENABLE_ACM} ${ENABLE_AC_RMF}", " ",d)}"

RDEPENDS_${PN}_remove = "${@bb.utils.contains('DISTRO_FEATURES', 'ipclient', ' audiocapturemgr', '', d)} "

DEPENDS_remove = " ${@bb.utils.contains('DISTRO_FEATURES', 'ipclient', ' audiocapturemgr',  '', d)}"

CFLAGS_remove = " ${@bb.utils.contains('DISTRO_FEATURES', 'ipclient', " ${@bb.utils.contains('RDEPENDS_${PN}',\
                    'virtual/media-utils', ' -I${STAGING_INCDIR}/media-utils/audioCapture', ' ', d)}", ' ',d)}"
