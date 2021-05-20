SUMMARY = "Devicesettings HAL Emulation for RPI"
SECTION = "console/utils"

LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://LICENSE;md5=175792518e4ac015ab6696d16c4f607e"

PROVIDES = "virtual/devicesettings-hal"
SRCREV = "${AUTOREV}"

PV = "${RDK_RELEASE}+git${SRCPV}"

PV_daisy = "r0"

SRC_URI = "${CMF_GIT_ROOT}/rdk/devices/raspberrypi/devicesettings;protocol=${CMF_GIT_PROTOCOL};branch=${CMF_GIT_BRANCH}"

S = "${WORKDIR}/git"

DEPENDS="devicesettings-hal-headers virtual/egl alsa-lib"

# mesa is the egl provider for vc4graphics
# but HAL implementation requires headers from userland
DEPENDS += "${@bb.utils.contains('MACHINE_FEATURES', 'vc4graphics', 'userland', '', d)}"

INCLUDE_DIRS = " \
    -I${STAGING_DIR_TARGET}${includedir}/rdk/ds-hal \
    "
# note: we really on 'make -e' to control LDFLAGS and CFLAGS from here. This is
# far from ideal, but this is to workaround the current component Makefile

CFLAGS += "-fPIC -D_REENTRANT -Wall ${INCLUDE_DIRS}"

export DSHAL_API_MAJOR_VERSION = '0'
export DSHAL_API_MINOR_VERSION = '0'

# a HAL is machine specific

PACKAGE_ARCH = "${MACHINE_ARCH}"

FILES_${PN} += "${libdir}/*.so*"
FILES_${PN} += "/opt/www/*.html"
FILES_${PN} += "/opt/persistent/ds/"
FILES_${PN} += "/opt/persistent/ds/*"

inherit coverity

do_compile() {
    oe_runmake -C ${S}/ -f Makefile clean
    oe_runmake -C ${S}/ -f Makefile
}

do_install() {
    # Install our HAL .h files required by the 'generic' devicesettings
    cd ${S}
    install -d ${D}${includedir}/rdk/ds-hal
    for i in *Settings.h ; do
        install -m 0644 $i ${D}${includedir}/rdk/ds-hal/
    done
    install -d ${D}${libdir}
    install -d ${D}/opt/persistent/ds
    oe_soinstall ${S}/libds-hal.so.${DSHAL_API_MAJOR_VERSION}.${DSHAL_API_MINOR_VERSION} ${D}${libdir}
    install -d ${D}${bindir} ${D}/opt/www
    install -m 0644 ${S}/platform.cfg ${D}${bindir}
    install -m 0755 ${S}/resolutionsettings.html ${D}/opt/www
    install -m 0755 ${S}/hostData ${D}/opt/persistent/ds/
}
