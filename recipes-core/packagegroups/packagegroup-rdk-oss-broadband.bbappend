
# linux-firmware-ralink provides /lib/firmware/rt*.bin (which includes
# /lib/firmware/rt2870.bin, which is required by hostapd on RPi).

RDEPENDS_packagegroup-rdk-oss-broadband_append = " \
    iw \
    wireless-tools \
    hostapd \
    linux-firmware-ralink \
    crda \
    ebtables \
    rtl8812au \
    rtl8192eu \
    rtl88x2bu \
    ethtool \
"

RDEPENDS_packagegroup-rdk-oss-broadband_remove_aarch64 = "alljoyn"
RDEPENDS_packagegroup-rdk-oss-broadband_append_dunfell = " zilker-sdk"
