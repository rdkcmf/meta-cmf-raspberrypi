FILESEXTRAPATHS_prepend := "${THISDIR}/files:"
SRC_URI_append_camera = " \
        file://wpa_supplicant.service \
        file://wpa_supplicant.conf \
"
SRC_URI_append_extender = " file://wpa_supplicant-global.service"

EXTRA_OEMAKE = "CONFIG_BUILD_WPA_CLIENT_SO=y"
FILES_SOLIBSDEV = ""
do_install_append () {
	install -d ${D}${includedir}
	install -d ${D}${libdir}

	install -m 0777 ${S}/wpa_supplicant/libwpa_client.so  ${D}${libdir}/
	install -m 0644 ${S}/src/common/wpa_ctrl.h ${D}${includedir}/
}

do_install_append_camera() {
        install -D -m 0644 ${WORKDIR}/wpa_supplicant.service ${D}/lib/systemd/system/wpa_supplicant.service
        install -D -m 0644 ${WORKDIR}/wpa_supplicant.conf ${D}/etc/wpa_supplicant.conf
}

do_install_append_extender () {
        install -m 0755 ${WORKDIR}/wpa_supplicant-global.service ${D}${systemd_unitdir}/system/
}

FILES_${PN} += "${libdir}/libwpa_client.so"
FILES_${PN} += "${includedir}/wpa_ctrl.h"

FILES_${PN}_append_camera = " \
  ${systemd_unitdir}/system/wpa_supplicant.service \
  ${sysconfdir}/wpa_supplicant.conf \
"

inherit systemd
SYSTEMD_SERVICE_${PN}_camera = "wpa_supplicant.service"
SYSTEMD_AUTO_ENABLE_camera = "enable"
FILES_${PN}_append_camera += "${systemd_unitdir}/system/*"

SYSTEMD_SERVICE_${PN}_extender = "wpa_supplicant-global.service"
SYSTEMD_AUTO_ENABLE_${PN}_extender = "enable"

