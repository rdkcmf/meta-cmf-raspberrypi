require ccsp_common_rpi.inc

FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

DEPENDS_append = " cjson"

LDFLAGS += " \
	-lutopiautil \
	-lcjson \
	   "

CFLAGS_append = " -D_ENABLE_BAND_STEERING_"
CFLAGS_append = " ${@bb.utils.contains('DISTRO_FEATURES', 'halVersion3', ' -DWIFI_HAL_VERSION_3 ', '', d)}"

SRC_URI_append = " \
    file://wifiTelemetrySetup.sh \
    file://checkwifi.sh \
    file://radio_param_def.cfg \
    file://bridge_mode.sh \
"
SRC_URI += "file://Ccspwifiagent_crash.patch;apply=no"
do_rpi_patches () {
    cd ${S}
    if [ ! -e rpi_patch_applied ]; then
       patch -p1 < ${WORKDIR}/Ccspwifiagent_crash.patch || echo "ERROR or Patch already applied"
       touch rpi_patch_applied
    fi
}
addtask rpi_patches after do_unpack before do_configure
do_configure_prepend() {
    sed -ni '/History/{x;d;};1h;1!{x;p;};${x;p;}' ${S}/config-atom/TR181-WiFi-USGv2.XML
    sed -i '/History/, +4d' ${S}/config-atom/TR181-WiFi-USGv2.XML
}

do_configure_prepend_aarch64() {
    sed -i "s/upload_client_debug_stats();/\/\/upload_client_debug_stats();/g" ${S}/source/TR-181/sbapi/wifi_monitor.c
}

do_install_append(){
    install -m 777 ${D}/usr/bin/CcspWifiSsp -t ${D}/usr/ccsp/wifi/
    install -m 755 ${S}/scripts/cosa_start_wifiagent.sh ${D}/usr/ccsp/wifi
    install -m 777 ${WORKDIR}/wifiTelemetrySetup.sh ${D}/usr/ccsp/wifi/
    install -m 777 ${WORKDIR}/checkwifi.sh ${D}/usr/ccsp/wifi/
    install -m 777 ${WORKDIR}/radio_param_def.cfg ${D}/usr/ccsp/wifi/
    install -m 777 ${WORKDIR}/bridge_mode.sh ${D}/usr/ccsp/wifi/
}

FILES_${PN} += " \
    ${prefix}/ccsp/wifi/CcspWifiSsp \
    ${prefix}/ccsp/wifi/cosa_start_wifiagent.sh \
    ${prefix}/ccsp/wifi/wifiTelemetrySetup.sh \
    ${prefix}/ccsp/wifi/checkwifi.sh \
    ${prefix}/ccsp/wifi/radio_param_def.cfg \
    ${prefix}/ccsp/wifi/bridge_mode.sh \
"
