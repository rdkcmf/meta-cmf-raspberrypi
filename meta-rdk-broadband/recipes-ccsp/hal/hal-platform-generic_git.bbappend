SRC_URI_append = " \
    ${CMF_GIT_ROOT}/rdkb/devices/raspberrypi/hal;protocol=${CMF_GIT_PROTOCOL};branch=${CMF_GIT_BRANCH};destsuffix=git/source/platform/devices_rpi;name=platformhal-raspberrypi \
"
SRCREV_platformhal-raspberrypi = "${AUTOREV}"

DEPENDS += "utopia-headers"
CFLAGS_append = " \
    -I=${includedir}/utctx \
"
CFLAGS_append_aarch64 = " -D_64BIT_ARCH_SUPPORT_"
do_configure_prepend(){
    rm ${S}/platform_hal.c
    ln -sf ${S}/devices_rpi/source/platform/platform_hal.c ${S}/platform_hal.c
    rm ${S}/Makefile.am
    ln -sf ${S}/devices_rpi/source/platform/Makefile.am ${S}/
}

