SUMMARY = "WiFi Client RDK HAL interface layer library for Raspberry Pi."
SECTION = "console/utils"

LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://LICENSE;md5=175792518e4ac015ab6696d16c4f607e"
PV = "${RDK_RELEASE}+git${SRCPV}"

PROVIDES = "virtual/wifi-hal"
RPROVIDES_${PN} = "virtual/wifi-hal"

SRC_URI = "${CMF_GIT_ROOT}/rdk/devices/raspberrypi/wifi;protocol=${CMF_GIT_PROTOCOL};branch=${CMF_GIT_BRANCH}"
SRCREV = "${AUTOREV}"

S = "${WORKDIR}/git"

DEPENDS="wifi-hal-headers wpa-supplicant"
RDEPENDS_${PN} += "wpa-supplicant"

EXTRA_OECONF += "--disable-static --disable-silent-rules"
EXTRA_OECONF_append = " --enable-wpa-supplicant=yes"

inherit autotools pkgconfig coverity
