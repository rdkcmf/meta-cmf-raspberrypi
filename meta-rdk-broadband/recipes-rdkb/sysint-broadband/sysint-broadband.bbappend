SRC_URI_append = " \
    ${CMF_GIT_ROOT}/rdkb/devices/raspberrypi/sysint;module=.;protocol=${CMF_GIT_PROTOCOL};branch=${CMF_GIT_BRANCH};destsuffix=git/devicerpi;name=sysintdevicerpi \
"
SRCREV_sysintdevicerpi = "${AUTOREV}"
SRCREV_FORMAT = "sysintgeneric_sysintdevicerpi"


do_install_append_rpi() {
    install -d ${D}${systemd_unitdir}/system
    install -m 0755 ${S}/device/lib/rdk/* ${D}${base_libdir}/rdk
    install -m 0755 ${S}/rfc.service ${D}${base_libdir}/rdk
    install -m 0755 ${S}/utils.sh ${D}${base_libdir}/rdk
    install -m 0755 ${S}/getpartnerid.sh ${D}${base_libdir}/rdk
    install -m 0755 ${S}/device/systemd_units/* ${D}${systemd_unitdir}/system/
    echo "BOX_TYPE=rpi" >> ${D}${sysconfdir}/device.properties
    echo "ARM_INTERFACE=erouter0" >> ${D}${sysconfdir}/device.properties
    echo "MODEL_NAME=RPI" >> ${D}${sysconfdir}/device.properties
    echo "ATOM_INTERFACE=br0" >> ${D}${sysconfdir}/device.properties
    echo "ATOM_INTERFACE_IP=192.168.101.3" >> ${D}${sysconfdir}/device.properties
    echo "ATOM_PROXY_SERVER=192.168.101.3" >> ${D}${sysconfdir}/device.properties
    echo "PARODUS_URL=tcp://127.0.0.1:6666" >> ${D}${sysconfdir}/device.properties
    echo "WEBPA_CLIENT_URL=tcp://192.168.101.3:6667" >> ${D}${sysconfdir}/device.properties
    echo "CLOUDURL="http://35.155.171.121:9092/xconf/swu/stb?eStbMac="" >> ${D}${sysconfdir}/include.properties
    echo "DCM_LOG_SERVER_URL="http://35.155.171.121:9092/loguploader/getSettings"" >> ${D}${sysconfdir}/dcm.properties
    echo "DCM_HTTP_SERVER_URL="http://35.155.171.121/xconf/telemetry_upload.php"" >> ${D}${sysconfdir}/dcm.properties
    echo "DCM_LA_SERVER_URL="http://35.155.171.121/xconf/logupload.php"" >> ${D}${sysconfdir}/dcm.properties
    #For rfc Support
    sed -i '/DEVICE_TYPE/c\DEVICE_TYPE=broadband' ${D}${sysconfdir}/device.properties
    sed -i '/LOG_PATH/c\LOG_PATH=/rdklogs/logs/' ${D}${sysconfdir}/device.properties
    #Erouter0 info
    sed -i "/f11/c\       mac=\`ifconfig \$WANINTERFACE | grep HWaddr | cut -d \" \" -f7\`" ${D}${base_libdir}/rdk/utils.sh
    sed -i '/Device.X_CISCO_COM_CableModem.MACAddress/{n;s/.*/    elif [ "$BOX_TYPE" = "XF3" ]; then/}' ${D}${base_libdir}/rdk/utils.sh
    #DCM simulator Support
    install -m 0755 ${S}/devicerpi/lib/rdk/StartDCM.sh ${D}${base_libdir}/rdk
    install -m 0755 ${S}/devicerpi/lib/rdk/DCMscript.sh ${D}${base_libdir}/rdk
    install -m 0755 ${S}/devicerpi/lib/rdk/uploadSTBLogs.sh ${D}${base_libdir}/rdk
    install -m 0755 ${S}/devicerpi/lib/rdk/interfaceCalls.sh ${D}${base_libdir}/rdk
    install -m 0755 ${S}/devicerpi/lib/rdk/commonUtils.sh ${D}${base_libdir}/rdk
    install -m 0755 ${S}/devicerpi/lib/rdk/logfiles.sh ${D}${base_libdir}/rdk
    install -m 0755 ${S}/devicerpi/lib/rdk/backupLogs.sh ${D}${base_libdir}/rdk
    install -m 0755 ${S}/devicerpi/lib/rdk/bank_image_switch.sh ${D}${base_libdir}/rdk
    install -m 0755 ${S}/devicerpi/lib/rdk/deviceInitiatedFWDnld.sh ${D}${base_libdir}/rdk
    install -m 0755 ${S}/devicerpi/lib/rdk/imageFlasher.sh ${D}${base_libdir}/rdk
    install -m 0755 ${S}/devicerpi/lib/rdk/rpi_sw_install.sh ${D}${base_libdir}/rdk
    install -m 0755 ${S}/devicerpi/lib/rdk/rpi_sw_install1.sh ${D}${base_libdir}/rdk
    install -m 0755 ${S}/devicerpi/lib/rdk/snmpUtils.sh ${D}${base_libdir}/rdk
    install -m 0755 ${S}/devicerpi/lib/rdk/rpi_image_Flasher.sh ${D}${base_libdir}/rdk
    install -m 0755 ${S}/devicerpi/lib/rdk/swupdate_utility.sh ${D}${base_libdir}/rdk
    install -m 0755 ${S}/devicerpi/lib/rdk/dcaSplunkUpload.sh ${D}${base_libdir}/rdk
    install -m 0755 ${S}/devicerpi/lib/rdk/dca_utility.sh ${D}${base_libdir}/rdk
    install -m 0755 ${S}/devicerpi/systemd_units/previous-log-backup.service ${D}${systemd_unitdir}/system
    install -m 0755 ${S}/devicerpi/systemd_units/swupdate.service ${D}${systemd_unitdir}/system
    install -m 0644 ${S}/devicerpi/systemd_units/hostapd_backup_check.service ${D}${systemd_unitdir}/system
    rm ${D}${systemd_unitdir}/system/dcm-log.service

    #NTPD 
    install -m 0644 ${S}/devicerpi/systemd_units/ntpd.service ${D}${systemd_unitdir}/system
 
    # Factory Reset Support
    install -d ${D}/fss/gw/rdklogger
    install -m 0755 ${S}/backupLogs.sh ${D}/fss/gw/rdklogger
    sed -i "s/RDK_LOGGER_PATH=\"\/rdklogger/RDK_LOGGER_PATH=\"\/lib\/rdk/g" ${D}/fss/gw/rdklogger/backupLogs.sh
    sed -i "/lib\/rdk/a LOG_BACK_UP_REBOOT=\"\/nvram\/logbackupreboot\"" ${D}/fss/gw/rdklogger/backupLogs.sh

    #Log Rotate Support
    install -m 0644 ${S}/logFiles.properties ${D}${sysconfdir}/
    echo "NVRAM2_SUPPORTED=yes" >> ${D}${sysconfdir}/device.properties
    # Commenting below line for proper working of telemetry cron job
    # install -m 0755 ${S}/dca_utility.sh   ${D}${base_libdir}/rdk
    install -m 0755 ${S}/getaccountid.sh   ${D}${base_libdir}/rdk
    install -m 0644 ${S}/dcmlogservers.txt   ${D}/rdklogger/
    sed -i "/if \[ \! -f \/usr\/bin\/GetConfigFile \]\;then/,+4d" ${D}/rdklogger/logfiles.sh 
    sed -i "/uploadRDKBLogs.sh/a \ \t \t  \t  uploading_rdklogs" ${D}/rdklogger/rdkbLogMonitor.sh
    sed -i "/uploadRDKBLogs.sh/d " ${D}/rdklogger/rdkbLogMonitor.sh
    sed -i "/upload_nvram2_logs()/i uploading_rdklogs() \n { \n \ \t \t TFTP_RULE_COUNT=\`iptables -t raw -L -n | grep tftp | wc -l\` \n \ \t \t if [ \"\$TFTP_RULE_COUNT\" == 0 ] \n \t \t then \n \ \t \t \t iptables -t raw -I OUTPUT -j CT -p udp -m udp --dport 69 --helper tftp \n \ \t \t \t sleep 2 \n \ \t \t fi \n \ \t \t cd /nvram2/logs \n \ \t \t FILENAME=\`ls *.tgz\` \n \ \t \t tftp -p -r \$FILENAME \$TFTP_SERVER_IP \n } " ${D}/rdklogger/rdkbLogMonitor.sh
    echo "TFTP_SERVER_IP=35.155.171.121" >> ${D}${sysconfdir}/device.properties

    #self heal support
    install -d ${D}/usr/ccsp/tad
    install -m 0755 ${S}/devicerpi/lib/rdk/corrective_action.sh ${D}/usr/ccsp/tad
    install -m 0755 ${S}/devicerpi/lib/rdk/self_heal_connectivity_test.sh ${D}/usr/ccsp/tad
    install -m 0755 ${S}/devicerpi/lib/rdk/resource_monitor.sh ${D}/usr/ccsp/tad
    install -m 0755 ${S}/devicerpi/lib/rdk/task_health_monitor.sh ${D}/usr/ccsp/tad
    install -m 0644 ${S}/devicerpi/systemd_units/disable_systemd_restart_param.service ${D}${systemd_unitdir}/system
    install -m 0755 ${S}/devicerpi/lib/rdk/disable_systemd_restart_param.sh ${D}${base_libdir}/rdk

    #Firmware Upgrade support
    echo "PART_SIZE_OFFSET=4194304" >> ${D}${sysconfdir}/device.properties

    #Remote Management Support
    install -m 0755 ${S}/devicerpi/lib/rdk/run_rm_key.sh   ${D}${base_libdir}/rdk 	
}

do_install_append_morty() {
    #Speed test support
    if ${@bb.utils.contains('DISTRO_FEATURES','nodejs','true','false',d)}; then
	 install -m 0755 ${S}/devicerpi/lib/rdk/npm.sh ${D}${base_libdir}/rdk
   	 install -m 0755 ${S}/devicerpi/systemd_units/npm.service ${D}${systemd_unitdir}/system
    fi
}

do_install_append_broadband-dev() {
install -m 0755 ${S}/devicerpi/lib/rdk/build_component_script.sh ${D}${base_libdir}/rdk
}
do_install_append_bootbroadband() {
    install -m 0755 ${S}/devicerpi/lib/rdk/flash.sh ${D}${base_libdir}/rdk
    install -m 0755 ${S}/devicerpi/lib/rdk/vm-to-image.sh ${D}${base_libdir}/rdk
    install -m 0755 ${S}/devicerpi/lib/rdk/curl-upload.sh ${D}${base_libdir}/rdk
    install -m 0755 ${S}/devicerpi/lib/rdk/monitor-upload.sh ${D}${base_libdir}/rdk
    install -m 0755 ${S}/devicerpi/systemd_units/boot-time-upload.service ${D}${systemd_unitdir}/system
    install -m 0755 ${S}/devicerpi/systemd_units/monitor-upload.service ${D}${systemd_unitdir}/system
}

SYSTEMD_SERVICE_${PN}_append_rpi = " dropbear.service disable_systemd_restart_param.service ntpd.service swupdate.service hostapd_backup_check.service"
SYSTEMD_SERVICE_${PN}_append_morty = "  ${@bb.utils.contains("DISTRO_FEATURES", "nodejs", " npm.service", " ", d)}"
SYSTEMD_SERVICE_${PN}_remove_broadband = "dropbear.service"
SYSTEMD_SERVICE_${PN}_append_bootbroadband += " boot-time-upload.service monitor-upload.service"

FILES_${PN}_append_rpi = " ${systemd_unitdir}/system/* /fss/gw/rdklogger/* /usr/ccsp/tad/*"
FILES_${PN}_append_bootbroadband = " ${systemd_unitdir}/system/*"
