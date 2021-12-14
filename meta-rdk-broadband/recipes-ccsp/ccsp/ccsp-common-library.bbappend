require ccsp_common_rpi.inc

FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:${THISDIR}/files:"

DEPENDS_append_rpi = " breakpad"
DEPENDS_append_dunfell = " ${@bb.utils.contains('DISTRO_FEATURES', 'safec', ' safec', " ", d)}"

CFLAGS_remove_aarch64= " -Werror"
CXXFLAGS_append_rpi = " \
                                -I${STAGING_INCDIR}/breakpad \
                                -std=c++11 \
                              "

SRC_URI_append = " \
    file://ccsp_vendor.h \
    file://wifiinitialized.service \
    file://checkrpiwifisupport.service \
    file://wifiinitialized.path \
    file://rpiwifiinitialized.path \
    file://checkrpiwifisupport.path \
    file://wifi-initialized.target \
    file://utopia.service \
    file://if_check.sh \
    file://brlan0_check.sh \ 
"
SRC_URI_append_lxcbrc += "\
   file://psm_container.sh \
   file://pandm_container.sh \
   file://wifi_container.sh \
"

# we need to patch to code for rpi
SRC_URI_remove_dunfell = "file://0001-DBusLoop-SSL_state-TLS_ST_OK.patch"
SRC_URI_remove_dunfell = "file://0001-SSLeay_add_all_algorithms-remove-in-openssl-1.1.patch"

SRC_URI_append_dunfell = " file://0001-DBusLoop-SSL_state-TLS_ST_OK.patch;apply=no"
SRC_URI_append_dunfell = " file://0001-SSLeay_add_all_algorithms-remove-in-openssl-1.1.patch;apply=no"

do_rpi_patches_dunfell () {
    cd ${S}
    if [ ! -e patch_applied ]; then
                 if [ "${@bb.utils.contains('DISTRO_CODENAME', 'dunfell', 'dunfell', '', d)}" = "dunfell" ] ; then
                              patch -p1 < ${WORKDIR}/0001-DBusLoop-SSL_state-TLS_ST_OK.patch
                              patch -p1 < ${WORKDIR}/0001-SSLeay_add_all_algorithms-remove-in-openssl-1.1.patch
                 fi
       touch patch_applied
    fi
}
addtask rpi_patches_dunfell after do_unpack before do_configure

do_install_append_class-target () {
    # Config files and scripts
    install -m 777 ${S}/scripts/cli_start_arm.sh ${D}/usr/ccsp/cli_start.sh
    install -m 777 ${S}/scripts/cosa_start_arm.sh ${D}/usr/ccsp/cosa_start.sh

    # we need unix socket path
    echo "unix:path=/var/run/dbus/system_bus_socket" > ${S}/config/ccsp_msg.cfg
    install -m 644 ${S}/config/ccsp_msg.cfg ${D}/usr/ccsp/ccsp_msg.cfg
    install -m 644 ${S}/config/ccsp_msg.cfg ${D}/usr/ccsp/cm/ccsp_msg.cfg
    install -m 644 ${S}/config/ccsp_msg.cfg ${D}/usr/ccsp/mta/ccsp_msg.cfg
    install -m 644 ${S}/config/ccsp_msg.cfg ${D}/usr/ccsp/pam/ccsp_msg.cfg
    install -m 644 ${S}/config/ccsp_msg.cfg ${D}/usr/ccsp/tr069pa/ccsp_msg.cfg

    install -m 777 ${S}/systemd_units/scripts/ccspSysConfigEarly.sh ${D}/usr/ccsp/ccspSysConfigEarly.sh
    install -m 777 ${S}/systemd_units/scripts/ccspSysConfigLate.sh ${D}/usr/ccsp/ccspSysConfigLate.sh
    install -m 777 ${S}/systemd_units/scripts/utopiaInitCheck.sh ${D}/usr/ccsp/utopiaInitCheck.sh
    install -m 777 ${S}/systemd_units/scripts/ccspPAMCPCheck.sh ${D}/usr/ccsp/ccspPAMCPCheck.sh

    install -m 777 ${S}/systemd_units/scripts/ProcessResetCheck.sh ${D}/usr/ccsp/ProcessResetCheck.sh
    sed -i -e "s/source \/rdklogger\/logfiles.sh;syncLogs_nvram2/#source \/rdklogger\/logfiles.sh;syncLogs_nvram2/g" ${D}/usr/ccsp/ProcessResetCheck.sh
    # install systemd services
    install -d ${D}${systemd_unitdir}/system
    install -D -m 0644 ${S}/systemd_units/ccspwifiagent.service ${D}${systemd_unitdir}/system/ccspwifiagent.service
    install -D -m 0644 ${S}/systemd_units/CcspCrSsp.service ${D}${systemd_unitdir}/system/CcspCrSsp.service
    install -D -m 0644 ${S}/systemd_units/CcspPandMSsp.service ${D}${systemd_unitdir}/system/CcspPandMSsp.service
    install -D -m 0644 ${S}/systemd_units/PsmSsp.service ${D}${systemd_unitdir}/system/PsmSsp.service
    install -D -m 0644 ${S}/systemd_units/rdkbLogMonitor.service ${D}${systemd_unitdir}/system/rdkbLogMonitor.service
    install -D -m 0644 ${S}/systemd_units/CcspTandDSsp.service ${D}${systemd_unitdir}/system/CcspTandDSsp.service
    install -D -m 0644 ${S}/systemd_units/CcspLMLite.service ${D}${systemd_unitdir}/system/CcspLMLite.service
    install -D -m 0644 ${S}/systemd_units/CcspTr069PaSsp.service ${D}${systemd_unitdir}/system/CcspTr069PaSsp.service
    install -D -m 0644 ${S}/systemd_units/snmpSubAgent.service ${D}${systemd_unitdir}/system/snmpSubAgent.service
    install -D -m 0644 ${S}/systemd_units/CcspEthAgent.service ${D}${systemd_unitdir}/system/CcspEthAgent.service
    install -D -m 0644 ${S}/systemd_units/notifyComp.service ${D}${systemd_unitdir}/system/notifyComp.service
    install -D -m 0644 ${S}/systemd_units/CcspTelemetry.service ${D}${systemd_unitdir}/system/CcspTelemetry.service

    #rfc service file
    install -D -m 0644 ${S}/systemd_units/rfc.service ${D}${systemd_unitdir}/system/rfc.service

    install -D -m 0644 ${WORKDIR}/wifiinitialized.service ${D}${systemd_unitdir}/system/wifiinitialized.service
    install -D -m 0644 ${WORKDIR}/checkrpiwifisupport.service ${D}${systemd_unitdir}/system/checkrpiwifisupport.service

    install -D -m 0644 ${WORKDIR}/wifiinitialized.path ${D}${systemd_unitdir}/system/wifiinitialized.path
    install -D -m 0644 ${WORKDIR}/rpiwifiinitialized.path ${D}${systemd_unitdir}/system/rpiwifiinitialized.path
    install -D -m 0644 ${WORKDIR}/checkrpiwifisupport.path ${D}${systemd_unitdir}/system/checkrpiwifisupport.path

    install -D -m 0644 ${WORKDIR}/wifi-initialized.target ${D}${systemd_unitdir}/system/wifi-initialized.target

    install -D -m 0644 ${S}/systemd_units/ProcessResetDetect.service ${D}${systemd_unitdir}/system/ProcessResetDetect.service
    install -D -m 0644 ${S}/systemd_units/ProcessResetDetect.path ${D}${systemd_unitdir}/system/ProcessResetDetect.path

    # Install wrapper for breakpad (disabled to support External Source build)
    #install -d ${D}${includedir}/ccsp
    #install -m 644 ${S}/source/breakpad_wrapper/include/breakpad_wrapper.h ${D}${includedir}/ccsp

    # Install "vendor information"
    install -m 0644 ${WORKDIR}/ccsp_vendor.h ${D}${includedir}/ccsp

    sed -i -- 's/NotifyAccess=.*/#NotifyAccess=main/g' ${D}${systemd_unitdir}/system/CcspCrSsp.service
    sed -i -- 's/notify.*/forking/g' ${D}${systemd_unitdir}/system/CcspCrSsp.service
   
    #copy rfc.properties into nvram
    sed -i '/ExecStartPre/ a\ExecStartPre=-/bin/cp /etc/rfc.properties /nvram/' ${D}${systemd_unitdir}/system/rfc.service
    sed -i 's#${PARODUS_START_LOG_FILE}#/rdklogs/logs/dcmrfc.log#g' ${D}${systemd_unitdir}/system/rfc.service
    sed -i 's/rfc.service /RFCbase.sh /g' ${D}${systemd_unitdir}/system/rfc.service
    #reduce sleep time to 12 sconds
    sed -i 's/300/12/g' ${D}${systemd_unitdir}/system/rfc.service

    #Remove pre execution script validation from Psm service
    sed -i "/utopiaInitCheck.sh/d" ${D}${systemd_unitdir}/system/PsmSsp.service
    sed -i "/log_psm.db.sh/d" ${D}${systemd_unitdir}/system/PsmSsp.service

    sed -i "/device.properties/a ExecStartPre=/bin/sh -c '(/usr/ccsp/utopiaInitCheck.sh)'"  ${D}${systemd_unitdir}/system/CcspPandMSsp.service
    sed -i "/PROCESS_RESTART_LOG/a ExecStartPost=/bin/sh  -c '(/usr/ccsp/wifi/bridge_mode.sh)'" ${D}${systemd_unitdir}/system/ccspwifiagent.service

    sed -i "/Description=CcspCrSsp service/a After=disable_systemd_restart_param.service" ${D}${systemd_unitdir}/system/CcspCrSsp.service

    #snmp module support
    sed -i "/tcp\:192.168.254.253\:705/a  ExecStart=\/usr\/bin\/snmp_subagent \&" ${D}${systemd_unitdir}/system/snmpSubAgent.service 	

    #Telemetry support
     sed -i "/Type=oneshot/a EnvironmentFile=\/etc/\device.properties" ${D}${systemd_unitdir}/system/CcspTelemetry.service
     sed -i "/EnvironmentFile=\/etc\/device.properties/a EnvironmentFile=\/etc\/dcm.properties" ${D}${systemd_unitdir}/system/CcspTelemetry.service
     sed -i "/EnvironmentFile=\/etc\/dcm.properties/a ExecStartPre=\/bin\/sh -c '\/bin\/touch \/rdklogs\/logs\/dcmscript.log'" ${D}${systemd_unitdir}/system/CcspTelemetry.service
     sed -i "s/ExecStart=\/bin\/sh -c '\/lib\/rdk\/dcm.service \&'/ExecStart=\/bin\/sh -c '\/lib\/rdk\/StartDCM.sh \>\> \/rdklogs\/logs\/telemetry.log \&'/g" ${D}${systemd_unitdir}/system/CcspTelemetry.service
     sed -i "s/wan-initialized.target/multi-user.target/g" ${D}${systemd_unitdir}/system/CcspTelemetry.service

     install -d ${D}${base_libdir}/rdk
     install -m 755 ${WORKDIR}/if_check.sh ${D}${base_libdir}/rdk/
     install -m 755 ${WORKDIR}/brlan0_check.sh ${D}${base_libdir}/rdk/
#WanManager - RdkWanManager.service
     DISTRO_WAN_ENABLED="${@bb.utils.contains('DISTRO_FEATURES','rdkb_wan_manager','true','false',d)}"
     if [ $DISTRO_WAN_ENABLED = 'true' ]; then
     install -D -m 0644 ${S}/systemd_units/RdkWanManager.service ${D}${systemd_unitdir}/system/RdkWanManager.service
     sed -i "/WorkingDirectory/a ExecStartPre=/bin/sh /lib/rdk/run_rm_key.sh" ${D}${systemd_unitdir}/system/RdkWanManager.service
     sed -i "s/After=CcspCrSsp.service/After=CcspCrSsp.service utopia.service PsmSsp.service/g" ${D}${systemd_unitdir}/system/RdkWanManager.service
     sed -i "s/CcspPandMSsp.service/CcspCrSsp.service CcspPandMSsp.service/g" ${D}${systemd_unitdir}/system/CcspEthAgent.service
     install -D -m 0644 ${WORKDIR}/utopia.service ${D}${systemd_unitdir}/system/utopia.service
     install -D -m 0644 ${S}/systemd_units/RdkTelcoVoiceManager.service ${D}${systemd_unitdir}/system/RdkTelcoVoiceManager.service
     install -D -m 0644 ${S}/systemd_units/RdkVlanManager.service ${D}${systemd_unitdir}/system/RdkVlanManager.service
     install -D -m 0644 ${S}/systemd_units/RdkFwUpgradeManager.service ${D}${systemd_unitdir}/system/RdkFwUpgradeManager.service
     install -D -m 0644 ${S}/systemd_units/CcspAdvSecuritySsp.service ${D}${systemd_unitdir}/system/CcspAdvSecuritySsp.service
     sed -i "s/wan-initialized.target/multi-user.target/g" ${D}${systemd_unitdir}/system/CcspAdvSecuritySsp.service
     fi

     ##### erouter0 ip issue
    sed -i '/Factory/a \
IsErouterRunningStatus=\`ifconfig erouter0 | grep RUNNING | grep -v grep | wc -l\` \
if [ \"\$IsErouterRunningStatus\" == 0 ]; then \
ethtool -s erouter0 speed 1000 \
fi' ${D}/usr/ccsp/ccspPAMCPCheck.sh

}

do_install_append_aarch64 () {
     DISTRO_WAN_ENABLED="${@bb.utils.contains('DISTRO_FEATURES','rdkb_wan_manager','true','false',d)}"
     if [ $DISTRO_WAN_ENABLED = 'true' ]; then
         sed -i "s/After=CcspCrSsp.service/After=CcspCrSsp.service utopia.service PsmSsp.service CcspEthAgent.service/g" ${D}${systemd_unitdir}/system/RdkWanManager.service
     fi  
}

do_install_append_class-target_lxcbrc () {

	install -d ${D}/lib/rdk/
	install  -m 0755 ${WORKDIR}/psm_container.sh ${D}/lib/rdk/
	install  -m 0755 ${WORKDIR}/pandm_container.sh ${D}/lib/rdk/
	install  -m 0755 ${WORKDIR}/wifi_container.sh ${D}/lib/rdk/


#Psm -  Psm.service

        sed -i "/-subsys/c\ExecStart=/bin/sh -c '(/container/PSMSSP/launcher/PsmSsp.sh start)'\nExecStop=/bin/sh -c '(/container/PSMSSP/launcher/PsmSsp.sh stop)'\n" ${D}${systemd_unitdir}/system/PsmSsp.service
 	sed -i "/ExecStart/ i\ExecStartPre=/bin/sh -c '(/lib/rdk/psm_container.sh)'" ${D}${systemd_unitdir}/system/PsmSsp.service

# P and m -  CcspPandM.service
        sed -i "/-subsys/c\ExecStart=/bin/sh -c '(/container/CCSPPANDM/launcher/CcspPandMSsp.sh start)'\nExecStop=/bin/sh -c '(/container/CCSPPANDM/launcher/CcspPandMSsp.sh stop)'\n" ${D}${systemd_unitdir}/system/CcspPandMSsp.service
 	sed -i "/EnvironmentFile/ a\ExecStartPre=-/bin/sh -c '(/lib/rdk/pandm_container.sh)'" ${D}${systemd_unitdir}/system/CcspPandMSsp.service

#WiFi - ccspwifiagent.service. This will be enabled/reported after bringing ccsp wifi component to stable state 
        sed -i "/-subsys/c\#ExecStart=/bin/sh -c '(/container/CCSPWIFI/launcher/CcspWifiSsp.sh start)'\n#ExecStop=/bin/sh -c '(/container/CCSPWIFI/launcher/CcspWifiSsp.sh stop)'\n" ${D}${systemd_unitdir}/system/ccspwifiagent.service

	sed -i "/ExecStart/ i\ExecStartPre=-/bin/sh -c '(/lib/rdk/wifi_container.sh)'" ${D}${systemd_unitdir}/system/ccspwifiagent.service
#CR - CcspCrSsp.service

        sed -i "/-subsys/c\ExecStart=/bin/sh -c '(/container/CCSPCR/launcher/CcspCrSsp.sh start)'\nExecStop=/bin/sh -c '(/container/CCSPCR/launcher/CcspCrSsp.sh stop)'\n" ${D}${systemd_unitdir}/system/CcspCrSsp.service

}



SYSTEMD_SERVICE_${PN} += "ccspwifiagent.service"
SYSTEMD_SERVICE_${PN} += "CcspCrSsp.service"
SYSTEMD_SERVICE_${PN} += "CcspPandMSsp.service"
SYSTEMD_SERVICE_${PN} += "PsmSsp.service"
SYSTEMD_SERVICE_${PN} += "rdkbLogMonitor.service"
SYSTEMD_SERVICE_${PN} += "CcspTandDSsp.service"
SYSTEMD_SERVICE_${PN} += "CcspLMLite.service"
SYSTEMD_SERVICE_${PN} += "CcspTr069PaSsp.service"
SYSTEMD_SERVICE_${PN} += "snmpSubAgent.service"
SYSTEMD_SERVICE_${PN} += "CcspEthAgent.service"
SYSTEMD_SERVICE_${PN} += "wifiinitialized.service"
SYSTEMD_SERVICE_${PN} += "checkrpiwifisupport.service"
SYSTEMD_SERVICE_${PN} += "wifiinitialized.path"
SYSTEMD_SERVICE_${PN} += "rpiwifiinitialized.path"
SYSTEMD_SERVICE_${PN} += "checkrpiwifisupport.path"
SYSTEMD_SERVICE_${PN} += "wifi-initialized.target"
SYSTEMD_SERVICE_${PN} += "ProcessResetDetect.path"
SYSTEMD_SERVICE_${PN} += "ProcessResetDetect.service"
SYSTEMD_SERVICE_${PN} += "rfc.service"
SYSTEMD_SERVICE_${PN} += "CcspTelemetry.service"
SYSTEMD_SERVICE_${PN} += "notifyComp.service"
SYSTEMD_SERVICE_${PN} += "${@bb.utils.contains('DISTRO_FEATURES', 'rdkb_wan_manager', 'RdkWanManager.service utopia.service CcspAdvSecuritySsp.service ', '', d)}"
SYSTEMD_SERVICE_${PN} += "${@bb.utils.contains('DISTRO_FEATURES', 'fwupgrade_manager', 'RdkFwUpgradeManager.service ', '', d)}"

FILES_${PN}_append = " \
    /usr/ccsp/ccspSysConfigEarly.sh \
    /usr/ccsp/ccspSysConfigLate.sh \
    /usr/ccsp/utopiaInitCheck.sh \
    /usr/ccsp/ccspPAMCPCheck.sh \
    /usr/ccsp/ProcessResetCheck.sh \
    ${base_libdir}/rdk/if_check.sh \
    ${base_libdir}/rdk/brlan0_check.sh \
    ${systemd_unitdir}/system/ccspwifiagent.service \
    ${systemd_unitdir}/system/CcspCrSsp.service \
    ${systemd_unitdir}/system/CcspPandMSsp.service \
    ${systemd_unitdir}/system/PsmSsp.service \
    ${systemd_unitdir}/system/rdkbLogMonitor.service \
    ${systemd_unitdir}/system/CcspTandDSsp.service \
    ${systemd_unitdir}/system/CcspLMLite.service \
    ${systemd_unitdir}/system/CcspTr069PaSsp.service \
    ${systemd_unitdir}/system/snmpSubAgent.service \
    ${systemd_unitdir}/system/CcspEthAgent.service \
    ${systemd_unitdir}/system/wifiinitialized.service \
    ${systemd_unitdir}/system/checkrpiwifisupport.service \
    ${systemd_unitdir}/system/wifiinitialized.path \
    ${systemd_unitdir}/system/rpiwifiinitialized.path \
    ${systemd_unitdir}/system/notifyComp.service \
    ${systemd_unitdir}/system/checkrpiwifisupport.path \
    ${systemd_unitdir}/system/wifi-initialized.target \
    ${systemd_unitdir}/system/ProcessResetDetect.path \
    ${systemd_unitdir}/system/ProcessResetDetect.service \
    ${systemd_unitdir}/system/rfc.service \
    ${systemd_unitdir}/system/CcspTelemetry.service \
"
FILES_${PN}_append = "${@bb.utils.contains('DISTRO_FEATURES', 'rdkb_wan_manager', ' ${systemd_unitdir}/system/RdkWanManager.service ${systemd_unitdir}/system/utopia.service ${systemd_unitdir}/system/RdkVlanManager.service ${systemd_unitdir}/system/RdkTelcoVoiceManager.service ${systemd_unitdir}/system/CcspAdvSecuritySsp.service ', '', d)}"
FILES_${PN}_append = "${@bb.utils.contains('DISTRO_FEATURES', 'fwupgrade_manager', ' ${systemd_unitdir}/system/RdkFwUpgradeManager.service ', '', d)}"
FILES_${PN}_append_lxcbrc = " \
	/lib/rdk/psm_container.sh \
   	/lib/rdk/pandm_container.sh \
   	/lib/rdk/wifi_container.sh \
"
