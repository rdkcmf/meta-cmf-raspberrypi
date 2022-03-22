SUMMARY = "RDK playersinkbin Gstreamer plugins implementation for RPI"
DESCRIPTION = "RDK playersinkbin for RPI mediaplayersink "

SECTION = "console/utils"

LICENSE = "LGPL-2.0"
LIC_FILES_CHKSUM = "file://COPYING;md5=a31bee46b377f5cd0c8c137adda53499"

PR = "r0"
PV = "${RDK_RELEASE}+git${SRCPV}"
SRCREV = "${AUTOREV}"

PROVIDES = "virtual/gst-plugins-playersinkbin"
RPROVIDES_${PN} = "virtual/gst-plugins-playersinkbin"

SRC_URI = "${CMF_GIT_ROOT}/rdk/devices/raspberrypi/gst-plugins-rdk/playersinkbin;protocol=${CMF_GIT_PROTOCOL};branch=${CMF_GIT_BRANCH}"

S = "${WORKDIR}/git"

FILESEXTRAPATHS_prepend := "${THISDIR}/files:"
SRC_URI += "file://0001-Gst-audio-decoder.patch;apply=no"
# using avdec_aac decoder
do_audio_decoder_patch() {
    cd ${S}
    if [ ! -e patch_applied ]; then
        bbnote "0001-Gst-audio-decoder.patch"
        patch -p1 < ${WORKDIR}/0001-Gst-audio-decoder.patch
        touch patch_applied
    fi
}
addtask audio_decoder_patch after do_unpack before do_configure

FILES_${PN} += "${libdir}/gstreamer-*/*.so"
FILES_${PN}-dev += "${libdir}/gstreamer-*/*.la"
FILES_${PN}-dbg += "${libdir}/gstreamer-*/.debug/*"
FILES_${PN}-staticdev += "${libdir}/gstreamer-*/*.a "

DEPENDS = "${@bb.utils.contains('DISTRO_FEATURES', 'gstreamer1', 'gstreamer1.0 gstreamer1.0-plugins-base', 'gstreamer gst-plugins-base', d)}"

ENABLE_GST1 = "--enable-gstreamer1=${@bb.utils.contains('DISTRO_FEATURES', 'gstreamer1', 'yes', 'no', d)}"
EXTRA_OECONF = " ${ENABLE_GST1}"

PACKAGECONFIG[subtec] = "--enable-subtec=yes,,,gst-plugins-rdk-subtec"

inherit autotools pkgconfig coverity

