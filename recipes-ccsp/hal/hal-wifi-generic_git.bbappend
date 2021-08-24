SRC_URI_append = " \
    ${CMF_GIT_ROOT}/rdkb/devices/raspberrypi/hal;protocol=${CMF_GIT_PROTOCOL};branch=${CMF_GIT_BRANCH};destsuffix=git/source/wifi/devices_rpi;name=wifihal-raspberrypi \
"

SRCREV_wifihal-raspberrypi = "${AUTOREV}"

DEPENDS +=" libev wpa-supplicant"

do_configure_prepend(){
    rm ${S}/wifi_hal.c
    rm ${S}/Makefile.am
    ln -sf ${S}/devices_rpi/source/wifi/wifi_hal.c ${S}/wifi_hal.c
    ln -sf ${S}/devices_rpi/source/wifi/client_wifi_hal.c ${S}/client_wifi_hal.c
    ln -sf ${S}/devices_rpi/source/wifi/wifi_hostapd_interface.c ${S}/wifi_hostapd_interface.c
    ln -sf ${S}/devices_rpi/source/wifi/rpi_wifi_hal_assoc_devices_details.c ${S}/rpi_wifi_hal_assoc_devices_details.c
    ln -sf ${S}/devices_rpi/include/wifi_hal.h ${S}/wifi_hal.h
    ln -sf ${S}/devices_rpi/source/wifi/Makefile.am ${S}/Makefile.am
}

CFLAGS_append = " ${@bb.utils.contains('DISTRO_FEATURES', 'extender', '-D_RPI_EXTENDER_', '', d)}"
