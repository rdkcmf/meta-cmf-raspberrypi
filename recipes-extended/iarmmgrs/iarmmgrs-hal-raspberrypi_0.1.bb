DESCRIPTION = "iarmmgrs-hal ir: irmgr-hal impelmented ; pwrmgr-hal Emulation"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://LICENSE;md5=b1e01b26bacfc2232046c90a330332b3"

PROVIDES = "virtual/iarmmgrs-hal"

SRCREV = "${AUTOREV}"
SRC_URI = "${CMF_GIT_ROOT}/rdk/devices/raspberrypi/iarmmgrs;protocol=${CMF_GIT_PROTOCOL};branch=${CMF_GIT_BRANCH}"

S = "${WORKDIR}/git"

DEPENDS="iarmmgrs-hal-headers"

inherit autotools coverity

EXTRA_OECONF += "--enable-dsleep"

