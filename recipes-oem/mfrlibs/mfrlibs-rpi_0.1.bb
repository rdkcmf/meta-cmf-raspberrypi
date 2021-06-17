DESCRIPTION = "mfrlibs implementation for RaspberryPi"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://LICENSE;md5=175792518e4ac015ab6696d16c4f607e"

DEPENDS = "iarmmgrs-hal-headers"

SRCREV = "${AUTOREV}"
SRC_URI = "${CMF_GIT_ROOT}/rdk/devices/raspberrypi/mfrlibs;protocol=${CMF_GIT_PROTOCOL};branch=${CMF_GIT_BRANCH}"

S = "${WORKDIR}/git"

PROVIDES = "virtual/mfrlib"
RPROVIDES_${PN} = "virtual/mfrlib"

EXTRA_OECONF += "--enable-thermalprotection"

inherit autotools coverity

