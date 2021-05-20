SYSTEMD_SERVICE_${PN} = ""

FILES_${PN}_append = " /lib/systemd/system/dnsmasq.service"

SYSTEMD_SERVICE_${PN} = "dnsmasq.service"

do_install_append_broadband(){
        sed -i '/Restart=always/s/^/#/' ${D}${systemd_unitdir}/system/dnsmasq.service
        sed -i '/#Restart=always/a RemainAfterExit=yes' ${D}${systemd_unitdir}/system/dnsmasq.service

        sed -i 's/\"XB3\" ]/& || [ \"$BOX_TYPE\" = \"rpi\" ]/' ${D}${base_libdir}/rdk/dnsmasqLauncher.sh
}
