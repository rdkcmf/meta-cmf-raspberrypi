EXTRA_OECONF_append = " --enable-ert --enable-platform"

SRC_URI_append = " \
   ${CMF_GIT_ROOT}/rdkb/devices/raspberrypi/tdkb;protocol=${CMF_GIT_PROTOCOL};branch=${CMF_GIT_BRANCH};destsuffix=git/platform/raspberrypi;name=tdkbraspberrypi \
"
SRCREV_tdkbraspberrypi = "${AUTOREV}"
do_fetch[vardeps] += "SRCREV_tdkbraspberrypi"
SRCREV_FORMAT = "tdk_tdkbraspberrypi"

do_install_append () {
    install -d ${D}${tdkdir}
    install -d ${D}/etc
    install -p -m 755 ${S}/platform/raspberrypi/agent/scripts/*.sh ${D}${tdkdir}
    install -p -m 755 ${S}/platform/raspberrypi/agent/scripts/tdk_platform.properties ${D}/etc/
}

FILES_${PN} += "${prefix}/ccsp/"
FILES_${PN} += "/etc/*"
FILES_${PN} += "${tdkdir}/*"
