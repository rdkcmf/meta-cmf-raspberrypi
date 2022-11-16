require ccsp_common_rpi.inc

FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI_lxcbrc += "file://bbhm_def_cfg_lxc.xml"

do_install_append() {
    # Config files and scripts
    install -d ${D}/usr/ccsp/config
    install -m 644 ${S}/config/bbhm_def_cfg_qemu.xml ${D}/usr/ccsp/config/bbhm_def_cfg.xml
    install -m 755 ${S}/scripts/bbhm_patch.sh ${D}/usr/ccsp/psm/bbhm_patch.sh
    sed -i '/NotifyWiFiChanges/a \
      <Record name="eRT.com.cisco.spvtg.ccsp.tr181pa.Device.WiFi.PreferPrivate" type="astr">1</Record> \
      <Record name="eRT.com.cisco.spvtg.ccsp.Device.WiFi.Radio.SSID.1.SSID" type="astr">RPI3_RDKB-AP0</Record> \
      <Record name="eRT.com.cisco.spvtg.ccsp.Device.WiFi.Radio.SSID.2.SSID" type="astr">RPI3_RDKB-AP1</Record> \
      <Record name="eRT.com.cisco.spvtg.ccsp.Device.WiFi.Radio.SSID.1.Passphrase" type="astr">rdk@1234</Record> \
      <Record name="eRT.com.cisco.spvtg.ccsp.Device.WiFi.Radio.SSID.2.Passphrase" type="astr">rdk@1234</Record>' ${D}/usr/ccsp/config/bbhm_def_cfg.xml
    sed -i '/2.SetChanUtilThreshold/a \
      <!--Band Steering Feature related --> \
      <Record name="eRT.com.cisco.spvtg.ccsp.Device.WiFi.X_RDKCENTRAL-COM_BandSteering.Enable" type="astr">false</Record> \
      <Record name="eRT.com.cisco.spvtg.ccsp.Device.WiFi.X_RDKCENTRAL-COM_BandSteering.BandSetting.1.RSSIThreshold" type="astr">-100</Record> \
      <Record name="eRT.com.cisco.spvtg.ccsp.Device.WiFi.X_RDKCENTRAL-COM_BandSteering.BandSetting.2.RSSIThreshold" type="astr">-100</Record>'  ${D}/usr/ccsp/config/bbhm_def_cfg.xml
    sed -i '/<Record name=\"eRT.com.cisco.spvtg.ccsp.tr181pa.Device.WiFi.AccessPoint.2.BssMaxNumSta\" type=\"astr\">30<\/Record>/d' ${D}/usr/ccsp/config/bbhm_def_cfg.xml
    sed -i '/<Record name=\"eRT.com.cisco.spvtg.ccsp.tr181pa.Device.WiFi.AccessPoint.1.BssMaxNumSta\" type=\"astr\">30<\/Record>/d' ${D}/usr/ccsp/config/bbhm_def_cfg.xml
    #WanManager Feature
    DISTRO_WAN_ENABLED="${@bb.utils.contains('DISTRO_FEATURES','rdkb_wan_manager','true','false',d)}"
    if [ $DISTRO_WAN_ENABLED = 'true' ]; then
    sed -i '/BandSetting.2.RSSIThreshold/a \
   <!-- rdkb-wanmanager related --> \
   <Record name="dmsb.wanmanager.wanenable" type="astr">1</Record> \
   <Record name="dmsb.wanmanager.wanifcount" type="astr">1</Record> \
   <Record name="dmsb.wanmanager.wanpolicy" type="astr">2</Record> \ 
   <Record name="dmsb.selfheal.rebootstatus"  type="astr">0</Record> \
   <Record name="dmsb.wanmanager.if.1.Name" type="astr">eth0</Record> \
   <Record name="dmsb.wanmanager.if.1.DisplayName" type="astr">WanOE</Record> \
   <Record name="dmsb.wanmanager.if.1.Enable" type="astr">TRUE</Record> \
   <Record name="dmsb.wanmanager.if.1.Type" type="astr">2</Record> \
   <Record name="dmsb.wanmanager.if.1.Priority" type="astr">0</Record> \
   <Record name="dmsb.wanmanager.if.1.SelectionTimeout" type="astr">60</Record> \
   <Record name="dmsb.wanmanager.if.1.Marking.List" type="astr">DATA</Record> \
   <Record name="dmsb.wanmanager.if.1.Marking.DATA.Alias" type="astr">DATA</Record> \
   <Record name="dmsb.wanmanager.if.1.Marking.DATA.SKBPort" type="astr">1</Record> \
   <Record name="dmsb.wanmanager.if.1.Marking.DATA.SKBMark" type="astr"> </Record> \
   <Record name="dmsb.wanmanager.if.1.Marking.DATA.EthernetPriorityMark" type="astr"></Record> \
   <Record name="dmsb.wanmanager.if.1.PPPEnable" type="astr">FALSE</Record> \
   <Record name="dmsb.wanmanager.if.1.PPPLinkType" type="astr">PPPoE</Record> \
   <Record name="dmsb.wanmanager.if.1.PPPIPCPEnable" type="astr">TRUE</Record> \
   <Record name="dmsb.wanmanager.if.1.PPPIPV6CPEnable" type="astr">TRUE</Record> \
   <Record name="dmsb.wanmanager.if.1.PPPIPCPEnable" type="astr">TRUE</Record> \
   <Record name="eRT.com.cisco.spvtg.ccsp.webpa.Device.X_RDK_WebConfig.RfcEnable" type="astr">false</Record> \
   <Record name="eRT.com.cisco.spvtg.ccsp.webpa.WebConfigRfcEnable" type="astr">false</Record>' ${D}/usr/ccsp/config/bbhm_def_cfg.xml

   # Add distro feature for changes below
   sed -i '/webpa.WebConfigRfcEnable/a \
   <!-- Ethernet interfaces of Raspberry Pi --> \
   <Record name="dmsb.ethagent.ethifcount" type="astr">1</Record> \
   <Record name="dmsb.ethagent.if.1.Name" type="astr">eth0</Record>' ${D}/usr/ccsp/config/bbhm_def_cfg.xml 
     fi
}

do_install_append_lxcbrc () {
 install -m 644 ${WORKDIR}/bbhm_def_cfg_lxc.xml ${D}/usr/ccsp/config/bbhm_def_cfg.xml
}

