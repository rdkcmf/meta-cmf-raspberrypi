RDEPENDS_packagegroup-rdk-media-common_remove_rpi = "\
    mfr-data \
"

RDEPENDS_packagegroup-rdk-media-common_remove_rpi_daisy = "\
        ${@bb.utils.contains("DISTRO_FEATURES", "gstreamer1", "gstreamer1.0-plugins-ugly", "gst-plugins-ugly", d)} \
"

RPI_WIFI_DEPENDENCY_KROGOTH = "\
   wireless-tools \
   linux-firmware-brcm43430 \
   wifi-hal-headers-dev \
"

RPI_WIFI_DEPENDENCY_MORTY = "\
   wireless-tools \
   linux-firmware-bcm43430 \
   wifi-hal-headers-dev \
"

RDEPENDS_packagegroup-rdk-media-common_append_rpi = "\
    ${@bb.utils.contains("DISTRO_FEATURES", "gstreamer1", "gstreamer1.0-libav", "gst-libav", d)} \
    ${@bb.utils.contains("DISTRO_FEATURES", "gstreamer1", "gstreamer1.0-plugins-ugly", "gst-plugins-ugly", d)} \
    ${@bb.utils.contains("DISTRO_FEATURES", "rdkshell", " rdkshell wpeframework-ui thunder-services", "", d)} \
    westeros-sink \
    liba52 \
    lirc \
    audiocapturemgr \
    aamp \
    tts \
    ledmgr-extended-noop \
    hdhomerun \
    rdkapps \
    ${@bb.utils.contains('MACHINE_FEATURES', 'vc4graphics', '', 'westeros-rpi-displaymod', d)} \
    dca \
    breakpad \
    breakpad-wrapper \
    parodus \
    libparodus \
    tr69hostif \
    iarm-set-powerstate \
    iarm-query-powerstate \
    key-simulator \
    power-state-monitor \
    sys-utils \
    rdk-gstreamer-utils \
"

RDEPENDS_packagegroup-rdk-media-common_remove_client = " \
    ${@bb.utils.contains('DISTRO_FEATURES', 'ipclient', ' \
        fog \
        rmfgeneric \
        rmfapp \
        rmfstreamer \
        rdkmediaplayer \
        sys-utils \
        tr69hostif \
        audiocapturemgr \
        thunder-services \
    ', '', d)} \
"

RDEPENDS_packagegroup-rdk-media-common_append_rpi_hybrid = "\
    gstqamtunersrc \
"

RDEPENDS_packagegroup-rdk-media-common_append_krogoth = "\
   ${@bb.utils.contains("DISTRO_FEATURES", "wifi", "${RPI_WIFI_DEPENDENCY_KROGOTH}", " ", d)} \
"

RDEPENDS_packagegroup-rdk-media-common_append_morty = "\
   ${@bb.utils.contains("DISTRO_FEATURES", "wifi", "${RPI_WIFI_DEPENDENCY_MORTY}", " ", d)} \
"
