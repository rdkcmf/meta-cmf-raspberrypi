do_install_append(){
        sed -i 's/After=moca.service sysmgr.service iarmbusd.service/After=sysmgr.service iarmbusd.service/g' ${D}${systemd_unitdir}/system/xupnp.service
        sed -i 's/Requires=moca.service sysmgr.service/Requires=sysmgr.service/g' ${D}${systemd_unitdir}/system/xupnp.service
        sed -i 's/After=lighttpd.service iarmbusd.service moca.service/After=lighttpd.service iarmbusd.service sysmgr.service/g' ${D}${systemd_unitdir}/system/xcal-device.service
        sed -i '/rmfCrshSupp/ a wareHouseMode=true' ${D}${sysconfdir}/xdevice.conf
}
do_install_append_hybrid() {
        sed -i '/AllowGwy=false/c\AllowGwy=true' ${D}${sysconfdir}/xdevice.conf
        install -m 0644 ${S}/conf/systemd/channel-map.service ${D}${systemd_unitdir}/system/channel-map.service
        install -m 0644 ${S}/conf/systemd/tune-ready.service ${D}${systemd_unitdir}/system/tune-ready.service
}
DISTRO_FEATURES_remove = " xcal_device"

SYSTEMD_SERVICE_${PN}_append_hybrid = " channel-map.service tune-ready.service"
