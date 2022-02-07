FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI += "file://startCVR.sh \
     file://cvr-launcher.service \
     file://cvr.conf \
"

S = "${WORKDIR}/git"

do_install_append() {
mkdir -p ${D}${prefix}/local/cvr

install -Dm755 ${WORKDIR}/startCVR.sh ${D}${base_libdir}/rdk/startCVR.sh
install -d ${D}${systemd_unitdir}/system
install -m 0644 ${WORKDIR}/cvr-launcher.service ${D}${systemd_unitdir}/system/

install -Dm755 ${WORKDIR}/cvr.conf ${D}${prefix}/local/cvr/
}

SYSTEMD_SERVICE_${PN}_append = "cvr-launcher.service"

FILES_${PN}_append = " \
     ${systemd_unitdir}/system/cvr-launcher.service \
     ${base_libdir}/rdk/startCVR.sh \
"

inherit systemd

