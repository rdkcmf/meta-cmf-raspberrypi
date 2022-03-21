SRC_URI_remove = "file://verbose.patch"
SRC_URI_remove = "file://revsshipv6.patch"
SYSTEMD_SERVICE_${PN}_remove_broadband = "dropbear.socket"

do_configure_prepend_hybrid () {
    export LIBS="${LIBS} -ltelemetry_msgsender"
}

do_configure_prepend_client () {
    export LIBS="${LIBS} -ltelemetry_msgsender"
}

do_configure_prepend_broadband () {
    export LIBS="${LIBS} -ltelemetry_msgsender"
}

do_install_append_broadband() {
  rm -rf ${D}${systemd_unitdir}
  rm -rf ${D}/lib
}
