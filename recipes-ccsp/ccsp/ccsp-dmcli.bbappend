require ccsp_common_rpi.inc

do_install_append_rpi () {
    ln -sf ${bindir}/dmcli ${D}${bindir}/ccsp_bus_client_tool
}
