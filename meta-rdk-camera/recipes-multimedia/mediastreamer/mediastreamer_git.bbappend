FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI += "file://startMST.sh \
     file://mst-launcher.service \
"

S = "${WORKDIR}/git"

do_configure_prepend() {
cp ${WORKDIR}/startMST.sh ${S}/
cp ${WORKDIR}/mst-launcher.service ${S}/
}

do_install_append() {
install -Dm755 ${S}/startMST.sh ${D}${base_libdir}/rdk/startMST.sh
install -d ${D}${systemd_unitdir}/system
install -m 0644 ${S}/mst-launcher.service ${D}${systemd_unitdir}/system/
}

SYSTEMD_SERVICE_${PN}_append = "mst-launcher.service"

FILES_${PN}_append = " \
     ${systemd_unitdir}/system/mst-launcher.service \
     ${base_libdir}/rdk/startMST.sh \
"
inherit systemd
