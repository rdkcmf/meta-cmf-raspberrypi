SRC_URI_remove = "file://verbose.patch"
SRC_URI_remove = "file://revsshipv6.patch"
SYSTEMD_SERVICE_${PN}_remove_broadband = "dropbear.socket"

do_install_append_broadband() {
  rm -rf ${D}${systemd_unitdir}
  rm -rf ${D}/lib
}
