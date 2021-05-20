require ccsp_common_rpi.inc

FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI_lxcbrc += "file://bbhm_def_cfg_lxc.xml"

do_configure_append() {
    install -m 644 ${S}/source-arm/psm_hal_apis.c -t ${S}/source/Ssp
}


do_install_append() {
    # Config files and scripts
    install -d ${D}/usr/ccsp/config
    install -m 644 ${S}/config/bbhm_def_cfg_qemu.xml ${D}/usr/ccsp/config/bbhm_def_cfg.xml
    install -m 755 ${S}/scripts/bbhm_patch.sh ${D}/usr/ccsp/psm/bbhm_patch.sh
    sed -i '/NotifyWiFiChanges/a \
      <Record name="eRT.com.cisco.spvtg.ccsp.Device.WiFi.Radio.SSID.1.SSID" type="astr">RPI3_RDKB-AP0</Record> \
      <Record name="eRT.com.cisco.spvtg.ccsp.Device.WiFi.Radio.SSID.2.SSID" type="astr">RPI3_RDKB-AP1</Record> \
      <Record name="eRT.com.cisco.spvtg.ccsp.Device.WiFi.Radio.SSID.1.Passphrase" type="astr">rdk@1234</Record> \
      <Record name="eRT.com.cisco.spvtg.ccsp.Device.WiFi.Radio.SSID.2.Passphrase" type="astr">rdk@1234</Record>' ${D}/usr/ccsp/config/bbhm_def_cfg.xml
    sed -i '/2.SetChanUtilThreshold/a \
      <!--Band Steering Feature related --> \
      <Record name="eRT.com.cisco.spvtg.ccsp.Device.WiFi.X_RDKCENTRAL-COM_BandSteering.Enable" type="astr">false</Record> \
      <Record name="eRT.com.cisco.spvtg.ccsp.Device.WiFi.X_RDKCENTRAL-COM_BandSteering.BandSetting.1.RSSIThreshold" type="astr">-100</Record> \
      <Record name="eRT.com.cisco.spvtg.ccsp.Device.WiFi.X_RDKCENTRAL-COM_BandSteering.BandSetting.2.RSSIThreshold" type="astr">-100</Record>' ${D}/usr/ccsp/config/bbhm_def_cfg.xml
}

do_install_append_lxcbrc () {
 install -m 644 ${WORKDIR}/bbhm_def_cfg_lxc.xml ${D}/usr/ccsp/config/bbhm_def_cfg.xml
}

