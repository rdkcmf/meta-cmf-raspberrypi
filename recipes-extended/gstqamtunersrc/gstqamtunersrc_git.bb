SUMMARY = "RDK playersinkbin Gstreamer plugins implementation for RDK emulator"
DESCRIPTION = "RDK playersinkbin for genric mediaplayersink "

SECTION = "console/utils"

LICENSE = "LGPL-2.0"
LIC_FILES_CHKSUM = "file://COPYING;md5=f59ca93195eb5b39481177fe70f7830b"

DEPENDS += "libtinyxml e2fsprogs rmfgeneric hdhomerun glib-2.0"

PR = "r0"
SRCREV = "${AUTOREV}"
PV = "${RDK_RELEASE}+git${SRCPV}"

SRC_URI = "${CMF_GIT_ROOT}/rdk/devices/intel-x86-pc/rdkemulator/gst-plugins-rdk/qamtunersrc;protocol=${CMF_GIT_PROTOCOL};branch=${CMF_GIT_BRANCH}"
S = "${WORKDIR}/git"

FILES_${PN} += "${libdir}/gstreamer-*/*.so"
FILES_${PN}-dev += "${libdir}/gstreamer-*/*.la"
FILES_${PN}-dbg += "${libdir}/gstreamer-*/.debug/*"
FILES_${PN}-staticdev += "${libdir}/gstreamer-*/*.a "

DEPENDS += "${@bb.utils.contains('DISTRO_FEATURES', 'gstreamer1', 'gstreamer1.0', 'gstreamer', d)}"

ENABLE_GST1 = "--enable-gstreamer1=${@bb.utils.contains('DISTRO_FEATURES', 'gstreamer1', 'yes', 'no', d)}"
EXTRA_OECONF = " ${ENABLE_GST1}"

CFLAGS += " -I${PKG_CONFIG_SYSROOT_DIR}${includedir}/hdhomerun"

CFLAGS += "-DQAM_LIVE_RPI"

LIB_DIRS += "-L${PKG_CONFIG_SYSROOT_DIR}/lib"
LDFLAGS += "${LIB_DIRS} -lhdhomerun"

INSANE_SKIP_${PN} = "dev-deps"

LDFLAGS += "-lgio-2.0 -lgstnet-1.0"

inherit autotools pkgconfig coverity
