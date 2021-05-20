SRC_URI_append = " \
    ${CMF_GIT_ROOT}/rdkb/devices/raspberrypi/hal;protocol=${CMF_GIT_PROTOCOL};branch=${CMF_GIT_BRANCH};destsuffix=git/source/wifi/devices;name=wifihal-raspberrypi \
"

FILESEXTRAPATHS_prepend := "${THISDIR}/files:"
SRC_URI_append = " file://wifi_variable_definitions.patch;apply=no"
SRC_URI_append = " file://wifi_function_definitions.patch;apply=no"

#This is workaround for missing do_patch when RDK uses external sources
do_rpi_patches() {
    cd ${WORKDIR}/git
        if [ ! -e patch_applied ]; then
            patch -p1 < ${WORKDIR}/wifi_variable_definitions.patch
            patch -p1 < ${WORKDIR}/wifi_function_definitions.patch
            touch patch_applied
        fi
}
addtask rpi_patches after do_configure before do_compile

SRCREV_wifihal-raspberrypi = "${AUTOREV}"

DEPENDS +=" libev wpa-supplicant"

do_configure_prepend(){
    rm ${S}/wifi_hal.c
    rm ${S}/Makefile.am
    ln -sf ${S}/devices/source/wifi/wifi_hal.c ${S}/wifi_hal.c
    ln -sf ${S}/devices/source/wifi/client_wifi_hal.c ${S}/client_wifi_hal.c
    ln -sf ${S}/devices/source/wifi/wifi_hostapd_interface.c ${S}/wifi_hostapd_interface.c
    ln -sf ${S}/devices/source/wifi/rpi_wifi_hal_assoc_devices_details.c ${S}/rpi_wifi_hal_assoc_devices_details.c
    ln -sf ${S}/devices/include/wifi_hal.h ${S}/wifi_hal.h
    ln -sf ${S}/devices/source/wifi/Makefile.am ${S}/Makefile.am
}

CFLAGS_append = " ${@bb.utils.contains('DISTRO_FEATURES', 'extender', '-D_RPI_EXTENDER_', '', d)}"
