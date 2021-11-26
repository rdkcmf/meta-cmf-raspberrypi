SRC_URI_append = " \
    ${CMF_GIT_ROOT}/rdkc/devices/raspberrypi/tdkc;protocol=${CMF_GIT_PROTOCOL};branch=${CMF_GIT_BRANCH};destsuffix=git/platform/raspberrypi;name=tdkcraspberrypi \
"
SRCREV_tdkcraspberrypi = "${AUTOREV}"

do_fetch[vardeps] += "SRCREV_tdkcraspberrypi"
SRCREV_FORMAT = "tdk_tdkcraspberrypi"

do_install_append () {
    install -d ${D}${tdkdir}
    install -p -m 755 ${S}/platform/raspberrypi/agent/scripts/*.sh ${D}${tdkdir}
}

FILES_${PN} += "${tdkdir}/*"
