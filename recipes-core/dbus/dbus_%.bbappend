PACKAGECONFIG_remove_krogoth = "systemd"

do_install_append_class-target_krogoth () {
    sed -i 's/ --address=systemd://' ${D}${systemd_system_unitdir}/dbus.service
}

do_install_append_lxcbrc () {

	sed -i '/user>messagebus/c\<user>dbus</user>'  ${D}/usr/share/dbus-1/system.conf
	sed -i '/allow user/c\<deny user="*"/>\n<allow user="ccspcr"/>\n<allow user="psm"/>\n<allow user="pandm"/>\n<allow user="ccspwifi"/>\n<allow user="ccsplmlite"/>\n<allow user="root"/>' ${D}/usr/share/dbus-1/system.conf
	
	sed -i '/ExecStart=/c\ExecStart=/container/DBUS/launcher/dbus.sh start' ${D}${systemd_system_unitdir}/dbus.service

	sed -i "/ExecStart=/i\ExecStartPre=-/bin/sh -c 'mkdir -p /container/DBUS/rootfs/var/run/dbus'\nExecStartPre=-/bin/sh -c 'chown -R dbus:dbus /container/DBUS/rootfs/var/run/dbus'" ${D}${systemd_system_unitdir}/dbus.service

	sed -i "/ExecStart=/a ExecStartPost=/bin/sh -c \'ln -sf /container/DBUS/rootfs/var/run/dbus/system_bus_socket /var/run/dbus/system_bus_socket\'"  ${D}${systemd_system_unitdir}/dbus.service

	sed -i "/ExecReload=/i ExecStop=/container/DBUS/launcher/dbus.sh stop"  ${D}${systemd_system_unitdir}/dbus.service

	sed -i "/ExecReload=/c\ExecReload=/container/DBUS/launcher/dbus.sh reload"  ${D}${systemd_system_unitdir}/dbus.service
}

do_install_append_aarch64_broadband () {
          # Removing dbus service in 64bit arch alone
          rm  ${D}${systemd_system_unitdir}/dbus.service   
}
