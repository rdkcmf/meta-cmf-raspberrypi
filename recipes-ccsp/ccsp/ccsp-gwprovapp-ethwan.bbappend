require ccsp_common_rpi.inc

FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI_append = " \
         file://if_check.sh \
"

export PLATFORM_RASPBERRYPI_ENABLED="yes"

DEPENDS_remove_dunfell = "hal-gwprovappabs"
LDFLAGS_remove_dunfell = "-lgwprovappabs"

inherit systemd

do_install_append () {
	install -d ${D}${systemd_unitdir}/system
	install -d ${D}${base_libdir}/rdk
	install -m 0644 ${S}/service/gwprovethwan.service ${D}${systemd_unitdir}/system
        sed -i "s/After=rg_network.service/After=network.target/g"  ${D}${systemd_unitdir}/system/gwprovethwan.service
        sed -i "/After=network.target/a wants=network.target"  ${D}${systemd_unitdir}/system/gwprovethwan.service
        sed -e '/Type/ s/^#*/#/' -i  ${D}${systemd_unitdir}/system/gwprovethwan.service
        sed -e '/ExecStartPre/ s/^#*/#/' -i  ${D}${systemd_unitdir}/system/gwprovethwan.service
        sed -i "/utopia_init.sh/a ExecStartPre=-/bin/sh -c 'mkdir -p /rdklogs/logs/'"  ${D}${systemd_unitdir}/system/gwprovethwan.service
        sed -i "/utopia_init.sh/a ExecStartPre=/bin/sh /lib/rdk/run_rm_key.sh" ${D}${systemd_unitdir}/system/gwprovethwan.service
        sed -i "/utopia_init.sh/a ExecStartPre=/bin/sh /lib/rdk/if_check.sh" ${D}${systemd_unitdir}/system/gwprovethwan.service
        sed -e '/ExecStartPost/ s/^#*/#/' -i  ${D}${systemd_unitdir}/system/gwprovethwan.service
        sed -i "/bin\/rm/a Restart=always"  ${D}${systemd_unitdir}/system/gwprovethwan.service
        sed -i "s/StandardOutput=syslog/StandardOutput=syslog+console/g"  ${D}${systemd_unitdir}/system/gwprovethwan.service
	sed -i "/rdklogs/a ExecStartPre=/bin/sh -c 'mkdir -p /nvram/'" ${D}${systemd_unitdir}/system/gwprovethwan.service
	sed -i "/nvram/a ExecStartPre=/bin/touch /nvram/ETHWAN_ENABLE" ${D}${systemd_unitdir}/system/gwprovethwan.service
        install -m 755 ${WORKDIR}/if_check.sh ${D}${base_libdir}/rdk/
}

SYSTEMD_SERVICE_${PN} = "gwprovethwan.service"
FILES_${PN} += " \
     ${systemd_unitdir}/system/gwprovethwan.service \
     ${base_libdir}/rdk/if_check.sh \
"
