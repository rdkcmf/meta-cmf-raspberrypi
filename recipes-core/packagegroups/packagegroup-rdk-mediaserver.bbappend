RDEPENDS_packagegroup-rdk-generic-mediaserver_remove = " \
    diagnostics-snmp2json \
    sys-utils \
    linux-fusion \
    directfb \
    udhcpc-opt43 \
"

RDEPENDS_packagegroup-rdk-generic-mediaserver_append = " \
    ${@bb.utils.contains('DISTRO_FEATURES', 'alexa_ffv', 'skillmapper', ' ', d)} \
    sysint \
    hdhomerun \
"
