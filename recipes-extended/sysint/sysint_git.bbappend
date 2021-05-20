# ============================================================================
# RDK MANAGEMENT, LLC CONFIDENTIAL AND PROPRIETARY
# ============================================================================
# This file (and its contents) are the intellectual property of RDK Management, LLC.
# It may not be used, copied, distributed or otherwise disclosed in whole or in
# part without the express written permission of RDK Management, LLC.
# ============================================================================
# Copyright (c) 2016 RDK Management, LLC. All rights reserved.
# ============================================================================

FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI_remove = "${CMF_GIT_ROOT}/rdk/devices/intel-x86-pc/emulator/sysint;module=.;protocol=${CMF_GIT_PROTOCOL};branch=${CMF_GIT_BRANCH};destsuffix=git/device;name=sysintdevice"
SRC_URI_append = " \
    ${CMF_GIT_ROOT}/rdk/devices/raspberrypi/sysint;module=.;protocol=${CMF_GIT_PROTOCOL};branch=${CMF_GIT_BRANCH};destsuffix=git/devicerpi;name=sysintdevicerpi \
"

SRC_URI_append = "              \
    file://bank_image_switch.sh \
    file://deviceInitiatedFWDnld.sh \
    file://imageFlasher.sh \
    file://rpi_sw_install1.sh \
    file://rpi_sw_install.sh  \
    file://swupdate_utility.sh  \
"

SRCREV_sysintdevicerpi = "${AUTOREV}"
SRCREV_FORMAT = "sysintgeneric_sysintdevicerpi"
S = "${WORKDIR}/git/devicerpi"

SYSTEMD_SERVICE_${PN}_remove = "disk-check.service"
SYSTEMD_SERVICE_${PN}_remove = "iptables.service"

common_install() {
    install -m 0755 ${S}/../lib/rdk/lighttpd-setup.sh ${D}${base_libdir}/rdk/
    install -m 0755 ${S}/../lib/rdk/opt-override.sh ${D}${base_libdir}/rdk/
    install -d ${D}/${sysconfdir}/
    install -m 0775 ${S}/etc/env_setup.sh ${D}${sysconfdir}
}

do_install_append_hybrid() {
    common_install

    rm -rf ${D}${systemd_unitdir}/system/dropbear.service

    install -m 0755 ${S}/devspec/lib/rdk/hrvinit.sh ${D}${base_libdir}/rdk/hrvinit.sh
    ln -sf /lib/rdk/hrvinit.sh ${D}/hrvinit
    sed -i -e '/Finish with adding SSH IPs/a\    if [ "\$BUILD_TYPE" != "dev" \]\n\    then' ${D}${base_libdir}/rdk/iptables_init
    sed -i -e '/\$IPV4_BIN \-A StaticSshWhiteList \-j SSHDROPLOG/a\    fi' ${D}${base_libdir}/rdk/iptables_init
    sed -i "s#curl -d '' -X POST http://127.0.0.1:50050/authService/getDeviceId >/tmp/gpid.txt#curl -d '' -X POST http://127.0.0.1:50050/authService/getDeviceId >/tmp/gpid.txt 2>/dev/null#g" ${D}${base_libdir}/rdk/getPartnerId.sh
    sed -i 's#. /etc/authService.conf##g' ${D}${base_libdir}/rdk/getPartnerId.sh
    install -m 0755 ${S}/devspec/lib/rdk/uploadSTBLogs.sh ${D}${base_libdir}/rdk
    install -m 0755 ${S}/devspec/lib/rdk/dca_utility.sh ${D}${base_libdir}/rdk
    install -m 0755 ${S}/devspec/lib/rdk/DCMscript.sh ${D}${base_libdir}/rdk
    install -m 0755 ${S}/devspec/lib/rdk/StartDCM.sh ${D}${base_libdir}/rdk
    install -m 0755 ${S}/devspec/lib/rdk/dcaSplunkUpload.sh ${D}${base_libdir}/rdk
    install -m 0755 ${S}/devspec/etc/log_timestamp.sh  ${D}${sysconfdir}/
    install -m 0755 ${S}/devspec/etc/common.properties  ${D}${sysconfdir}
    install -m 0755 ${S}/devspec/etc/device.properties  ${D}${sysconfdir}
    install -m 0755 ${S}/devspec/etc/dcm.properties     ${D}${sysconfdir}
}

do_install_append_client() {
    common_install

    rm -rf ${D}${systemd_unitdir}/system/dropbear.service

    if [ -f ${D}${sysconfdir}/mc-device.properties ]; then
        mv ${D}${sysconfdir}/mc-device.properties ${D}${sysconfdir}/device.properties
    fi
    if [ -f ${D}${sysconfdir}/mc-common.properties ]; then
        mv ${D}${sysconfdir}/mc-common.properties ${D}${sysconfdir}/common.properties
    fi
}

do_install_append_camera(){
    common_install

        install -m 0644 ${S}/../systemd_units/dnsmerge-udhcpc.path ${D}${systemd_unitdir}/system
        install -m 0644 ${S}/../systemd_units/dnsmerge-upnp.path ${D}${systemd_unitdir}/system
        install -m 0644 ${S}/../systemd_units/dnsmerge.service ${D}${systemd_unitdir}/system

        install -m 0644 ${S}/devspec/systemd_units/amixer.service ${D}${systemd_unitdir}/system
        install -m 0644 ${S}/devspec/systemd_units/dropbear-insecure.service ${D}${systemd_unitdir}/system/dropbear.service
        install -m 0755 ${S}/devspec/systemd_units/amixer.sh ${D}${bindir}/amixer.sh
        install -m 0644 ${S}/devspec/etc/common.properties ${D}${sysconfdir}/common.properties
        install -m 0644 ${S}/devspec/etc/device.properties ${D}${sysconfdir}/device.properties
        install -m 0644 ${S}/devspec/systemd_units/nvram.service ${D}${systemd_unitdir}/system

        if [ -d ${D}/HrvInitScripts ]; then
            rm -rf ${D}/HrvInitScripts
        fi

        if [ -d ${D}${base_libdir}/rdk ]; then
            rm -rf ${D}${base_libdir}/rdk/startSSH.sh
            rm -rf ${D}${base_libdir}/rdk/devicetype.sh
            rm -rf ${D}${base_libdir}/rdk/getDeviceDetails.sh
            rm -rf ${D}${base_libdir}/rdk/getNumberOfStartupSteps.sh
            rm -rf ${D}${base_libdir}/rdk/getProgress.sh
            rm -rf ${D}${base_libdir}/rdk/ipIfaceMonitor.sh
            rm -rf ${D}${base_libdir}/rdk/startIpGw.sh
            rm -rf ${D}${base_libdir}/rdk/tr69FWDnld.sh
            rm -rf ${D}${base_libdir}/rdk/docsis_utility.sh
            rm -rf ${D}${base_libdir}/rdk/moca*
            rm -rf ${D}${base_libdir}/rdk/ecmIpMonitor.sh
            rm -rf ${D}${base_libdir}/rdk/factory-reset.sh
            rm -rf ${D}${base_libdir}/rdk/firmwareDwnld.sh
            rm -rf ${D}${base_libdir}/rdk/fkps.sh
            rm -rf ${D}${base_libdir}/rdk/RFC*
            rm -rf ${D}${base_libdir}/rdk/cleanAdobe.sh
            rm -rf ${D}${base_libdir}/rdk/clearACSConf.sh
            rm -rf ${D}${base_libdir}/rdk/coldfactory-reset.sh
            rm -rf ${D}${base_libdir}/rdk/dca_utility.sh
            rm -rf ${D}${base_libdir}/rdk/DCMscript.sh
            rm -rf ${D}${base_libdir}/rdk/getLSAParamFromRFC.sh
            rm -rf ${D}${base_libdir}/rdk/idsUtility.sh
            rm -rf ${D}${base_libdir}/rdk/intrusionSender.sh
            rm -rf ${D}${base_libdir}/rdk/ipDownload_soc.sh
            rm -rf ${D}${base_libdir}/rdk/launchSocProv.sh
            rm -rf ${D}${base_libdir}/rdk/reboot*
            rm -rf ${D}${base_libdir}/rdk/restartReceiver.sh
            rm -rf ${D}${base_libdir}/rdk/restorepwrstate.sh
            rm -rf ${D}${base_libdir}/rdk/runXRE
            rm -rf ${D}${base_libdir}/rdk/shutdownReceiver.sh
            rm -rf ${D}${base_libdir}/rdk/snmp*
            rm -rf ${D}${base_libdir}/rdk/StartDCM.sh
            rm -rf ${D}${base_libdir}/rdk/stopocap.sh
            rm -rf ${D}${base_libdir}/rdk/swupdate_utility.sh
            rm -rf ${D}${base_libdir}/rdk/updateRF4CEmac.sh
            rm -rf ${D}${base_libdir}/rdk/uploadSTBLogs.sh
            rm -rf ${D}${base_libdir}/rdk/userInitiatedFWDnld.sh
            rm -rf ${D}${base_libdir}/rdk/warehouse-reset.sh
            rm -rf ${D}${base_libdir}/rdk/whreset.sh
            rm -rf ${D}${base_libdir}/rdk/xiConnectionStatus.sh
            rm -rf ${D}${base_libdir}/rdk/xre-dumpLogs.sh
            rm -rf ${D}${base_libdir}/rdk/xreInterfaceCalls.sh
            rm -rf ${D}${base_libdir}/rdk/xreproxypatterns.conf
            rm -rf ${D}${base_libdir}/rdk/post*
            rm -rf ${D}${base_libdir}/rdk/setDeviceIdXr11.sh
            rm -rf ${D}${base_libdir}/rdk/hrvinit.sh
            rm -rf ${D}${base_libdir}/rdk/alertSystem.sh
            rm -rf ${D}${base_libdir}/rdk/networkCommnCheck.sh
            rm -rf ${D}${base_libdir}/rdk/serialNumber.sh
            rm -rf ${D}${base_libdir}/rdk/ping*
            rm -rf ${D}${base_libdir}/rdk/iptables_init
        fi

        if [ -d ${D}${sysconfdir} ]; then
            rm -rf ${D}${sysconfdir}/dcmlogservers.txt
            rm -rf ${D}${sysconfdir}/dcmservers.txt
            rm -rf ${D}${sysconfdir}/dcmscpservers.txt
            rm -rf ${D}${sysconfdir}/rfc.properties
            rm -rf ${D}${sysconfdir}/xre.properties
            rm -rf ${D}${sysconfdir}/warehouseHosts.conf
        fi

        install -m 0755 ${S}/devspec/lib/rdk/startSSH.sh ${D}${base_libdir}/rdk/startSSH.sh
        # RPI does not have moca dont spin on it
        install -m 0755 ${S}/devspec/lib/rdk/devicetype.sh ${D}${base_libdir}/rdk/devicetype.sh
        install -m 0755 ${S}/devspec/lib/rdk/serialNumber.sh ${D}${base_libdir}/rdk/serialNumber.sh
        install -m 0755 ${S}/devspec/etc/prepare_logs ${D}${sysconfdir}
        install -m 0755 ${S}/devspec/lib/rdk/getDeviceDetails.sh ${D}${base_libdir}/rdk/getDeviceDetails.sh

        if [ -f ${D}${systemd_unitdir}/system/ntp-event.service ]; then
            sed -i 's#ExecStart=/usr/bin/IARM_event_sender#ExecStartPost=/usr/bin/IARM_event_sender#g' ${D}${systemd_unitdir}/system/ntp-event.service

            sed -i '$ a [Install]' ${D}${systemd_unitdir}/system/ntp-event.service
            sed -i '$ a WantedBy=multi-user.target' ${D}${systemd_unitdir}/system/ntp-event.service
        fi

        sed -i -e 's/LOG_SERVER=.*$/LOG_SERVER=/' ${D}${sysconfdir}/config.properties
        sed -i -e 's/DCM_LOG_SERVER=.*$/DCM_LOG_SERVER=/' ${D}${sysconfdir}/config.properties
        sed -i -e 's/DCM_LOG_SERVER_URL=.*$/DCM_LOG_SERVER_URL=/' ${D}${sysconfdir}/config.properties
        sed -i -e 's/DCM_SCP_SERVER=.*$/DCM_SCP_SERVER=/' ${D}${sysconfdir}/config.properties
        sed -i -e 's/CRASH_SVR=.*$/CRASH_SVR=/' ${D}${sysconfdir}/config.properties
        sed -i -e 's/POTOMAC_SVR=.*$/POTOMAC_SVR=/' ${D}${sysconfdir}/config.properties
        sed -i -e 's/TFTP_SVR=.*$/TFTP_SVR=/' ${D}${sysconfdir}/config.properties

        if [ -d ${D}${systemd_unitdir}/system ]; then
            rm -rf ${D}${systemd_unitdir}/system/virtual-moca-iface.service
            rm -rf ${D}${systemd_unitdir}/system/xi-connection-stats.service
            rm -rf ${D}${systemd_unitdir}/system/xi-connection-stats.timer
            rm -rf ${D}${systemd_unitdir}/system/ip-setup-monitor.service
            rm -rf ${D}${systemd_unitdir}/system/ip-iface-monitor.service
            rm -rf ${D}${systemd_unitdir}/system/rfc-config.service
            rm -rf ${D}${systemd_unitdir}/system/ping-telemetry.service
            rm -rf ${D}${systemd_unitdir}/system/ping-telemetry.timer
        fi

        if [ -f ${D}${base_libdir}/rdk/getPartnerId.sh ]; then
            sed -i -e '/authService.conf/d' ${D}${base_libdir}/rdk/getPartnerId.sh
            sed -i -e 's/getPartnerId/_getPartnerId/g' ${D}${base_libdir}/rdk/getPartnerId.sh
            linenum="$(grep -n "_getPartnerId" ${D}${base_libdir}/rdk/getPartnerId.sh|head -n 1|cut -d: -f1)"
            linenum=`expr $linenum - 1 `
            sed -i -e  "$linenum a getPartnerId\(\)\\n\{\\n    echo \"unknown\"\\n\}\\n" ${D}${base_libdir}/rdk/getPartnerId.sh 
        fi

        sed -i '/DEVICE_TYPE/c\DEVICE_TYPE=camera' ${D}${sysconfdir}/device.properties
}

do_install_append_rpi() {
             install -d ${D}${base_libdir}/rdk
             install -m 0755 ${WORKDIR}/bank_image_switch.sh ${D}${base_libdir}/rdk 
             install -m 0755 ${WORKDIR}/deviceInitiatedFWDnld.sh ${D}${base_libdir}/rdk 
             install -m 0755 ${WORKDIR}/imageFlasher.sh ${D}${base_libdir}/rdk 
             install -m 0755 ${WORKDIR}/rpi_sw_install1.sh ${D}${base_libdir}/rdk 
             install -m 0755 ${WORKDIR}/rpi_sw_install.sh ${D}${base_libdir}/rdk 
             install -m 0755 ${WORKDIR}/swupdate_utility.sh  ${D}${base_libdir}/rdk 
	     echo "CLOUDURL="http://35.155.171.121:9092/xconf/swu/stb?eStbMac="" >> ${D}${sysconfdir}/include.properties
             #setting the path for rtl_json.txt in rdk-v to upload the markers into the server are added newly to include.properties
             echo ""TELEMETRY_JSON_RESPONSE=/opt/rtl_json.txt"" >> ${D}${sysconfdir}/include.properties
             # URL is hard coded for rdk-v to communicate with xconfig server of telemetry markers are added newly to include.properties
             echo ""P=http://35.155.171.121:9092/loguploader/getSettings"" >> ${D}${sysconfdir}/include.properties

# Give Partition offset size in sector based. 
#    1 sector = 512
# for Ex : Allocating 1GB for partition 
#    2GB = ( 1024 * 1024 * 1024 ) * 2
#    sector size for 1GB = (1024*1024*1024)*2/512 = 4194304 sectors
#    Finally need to give partition size offset is 4194304 for 1GB partiton allocation.
             echo "PART_SIZE_OFFSET=4194304" >> ${D}${sysconfdir}/device.properties
}

SYSTEMD_SERVICE_${PN}_remove = " virtual-moca-iface.service dropbear.service"

SYSTEMD_SERVICE_${PN}_append_camera = " dump-log.timer"
SYSTEMD_SERVICE_${PN}_append_camera = " dnsmerge-upnp.path"
SYSTEMD_SERVICE_${PN}_append_camera = " dnsmerge-udhcpc.path"
SYSTEMD_SERVICE_${PN}_append_camera = " dnsmerge.service"

SYSTEMD_SERVICE_${PN}_append_camera = " amixer.service"
SYSTEMD_SERVICE_${PN}_append_camera = " dropbear.service"
SYSTEMD_SERVICE_${PN}_append_camera = " nvram.service"

SYSTEMD_SERVICE_${PN}_remove_camera = "xi-connection-stats.service"
SYSTEMD_SERVICE_${PN}_remove_camera = "xi-connection-stats.timer"
SYSTEMD_SERVICE_${PN}_remove_camera = "ip-setup-monitor.service"
SYSTEMD_SERVICE_${PN}_remove_camera = "ping-telemetry.service"
SYSTEMD_SERVICE_${PN}_remove_camera = "ping-telemetry.timer"
SYSTEMD_SERVICE_${PN}_remove_camera = "rfc-config.service"
SYSTEMD_SERVICE_${PN}_remove_camera = "disk-check.service"

FILES_${PN}_append_camera = " ${bindir}/*"
FILES_${PN}_append_camera = " ${systemd_unitdir}/system/*"
FILES_${PN}_append_camera = " /opt/*"

FILES_${PN}_remove_camera = "${systemd_unitdir}/system/virtual-moca-iface.service"
FILES_${PN}_remove_camera = "${systemd_unitdir}/system/ip-setup-monitor.service"
FILES_${PN}_remove_camera = "${systemd_unitdir}/system/ip-iface-monitor.service"
FILES_${PN}_remove_camera = "${systemd_unitdir}/system/ping-telemetry.service"
FILES_${PN}_remove_camera = "${systemd_unitdir}/system/ping-telemetry.timer"
FILES_${PN}_remove_camera = "${systemd_unitdir}/system/rfc-config.service"

SYSTEMD_SERVICE_${PN}_remove_hybrid = " swupdate.service"
SYSTEMD_SERVICE_${PN}_remove_hybrid = " virtual-moca-iface.service dropbear.service"

FILES_${PN} += "${sysconfdir}/env_setup.sh"

FILES_${PN}_append_hybrid = "/hrvinit"
