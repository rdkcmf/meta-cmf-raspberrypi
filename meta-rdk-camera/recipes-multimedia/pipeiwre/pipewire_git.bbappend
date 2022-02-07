FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI += "file://startPipeWire.sh \
     file://pipewire-launcher.service \
"

S = "${WORKDIR}/git"

do_install_append() {
install -Dm755 ${WORKDIR}/startPipeWire.sh ${D}${base_libdir}/rdk/startPipeWire.sh
install -d ${D}${systemd_unitdir}/system
install -m 0644 ${WORKDIR}/pipewire-launcher.service ${D}${systemd_unitdir}/system/

}

SYSTEMD_SERVICE_${PN}_append = "pipewire-launcher.service"

FILES_${PN}_append = " \
     ${systemd_unitdir}/system/pipewire-launcher.service \
     ${base_libdir}/rdk/startPipeWire.sh \
"

inherit systemd
