FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI_append_camera = " \
    file://startParodus.sh \
    file://parodus.service \
"

LDFLAGS_append = " -Wl,--no-as-needed -lm -llog4c -lrdkloggers"

inherit systemd coverity

SRC_URI_append_broadband = " \
        ${CMF_GIT_ROOT}/rdk/devices/raspberrypi/webpa-client;protocol=${CMF_GIT_PROTOCOL};branch=${CMF_GIT_BRANCH};destsuffix=git/devices;name=rdkbrpi \
"

SRCREV_rdkbrpi = "${AUTOREV}"
do_fetch[vardeps] += "SRCREV_rdkbrpi"
SRCREV_FORMAT .= "_rdkbrpi"

do_install_append_broadband () {
    install -d ${D}${systemd_unitdir}/system
    install -d ${D}${base_libdir_native}/rdk
    install -m 0644 ${S}/devices/broadband/parodus/systemd/parodus.service ${D}${systemd_unitdir}/system
    install -m 0755 ${S}/devices/broadband/parodus/scripts/parodus_start.sh ${D}${base_libdir_native}/rdk
}

do_install_append_camera () {
    install -Dm755 ${WORKDIR}/startParodus.sh ${D}${base_libdir}/rdk/startParodus.sh
    install -d ${D}${systemd_unitdir}/system
    install -m 0644 ${WORKDIR}/parodus.service ${D}${systemd_unitdir}/system/
}

SYSTEMD_SERVICE_${PN}_append_broadband = " parodus.service"
SYSTEMD_SERVICE_${PN}_append_camera = " parodus.service"

FILES_${PN}_append_broadband = " \
     ${systemd_unitdir}/system/parodus.service \
     ${base_libdir_native}/rdk/* \
"

FILES_${PN}_append_camera = " \
     ${systemd_unitdir}/system/parodus.service \
     ${base_libdir}/rdk/startParodus.sh \
"
