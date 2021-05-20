SRC_URI_append = " \
    ${CMF_GIT_ROOT}/rdkb/devices/raspberrypi/hal;protocol=${CMF_GIT_PROTOCOL};branch=${CMF_GIT_BRANCH};destsuffix=git/source/ethsw/devices;name=ethswhal-raspberrypi \
"
SRCREV_ethswhal-raspberrypi = "${AUTOREV}"

do_configure_prepend(){
    ln -sf ${S}/devices/source/hal-ethsw/ccsp_hal_ethsw.c ${S}/ccsp_hal_ethsw.c
}


