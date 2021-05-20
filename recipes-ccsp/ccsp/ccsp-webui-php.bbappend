require ccsp_common_rpi.inc

FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

EXTRA_OECONF += "PHP_RPATH=no"

SRC_URI_append = " \
    ${CMF_GIT_ROOT}/rdkb/devices/raspberrypi/sysint;protocol=${CMF_GIT_PROTOCOL};branch=${CMF_GIT_BRANCH};destsuffix=sysint/devicerpi;name=rdkbsysintrpi \
"
SRCREV_rdkbsysintrpi = "${AUTOREV}"

SRC_URI_append = " \
	 file://CcspWebUI.sh \
	 file://CcspWebUI.service \
"

do_install_append () {
    install -d ${D}${sysconfdir}
    install -m 755 ${S}/../Styles/xb3/config/php.ini ${D}${sysconfdir}

    # delete wan0 reference for R-Pi
    sed -i "/wan0:80/a  echo \"This interface is not available in RPI\""  ${D}${sysconfdir}/webgui.sh
    sed -i "/wan0:443/a  echo \"This interface is not available in RPI\""  ${D}${sysconfdir}/webgui.sh
    sed -i "s/if \[ \"\$BOX_TYPE\" == \"HUB4\" \]/if \[ \"\$BOX_TYPE\" = \"HUB4\" \]/g" ${D}${sysconfdir}/webgui.sh
    sed -i '/wan0/d' ${D}${sysconfdir}/webgui.sh

    #delete server.pem reference for R-Pi
    sed -e '/\$INTERFACE:10443/ s/^#*/echo "Removed server.pem references for R-pi"\n#/' -i ${D}${sysconfdir}/webgui.sh
    sed -e '/\$INTERFACE:18080/ s/^#*/echo "Removed server.pem references for R-pi"\n#/' -i ${D}${sysconfdir}/webgui.sh

    sed -i -e "s/'TCP',\ 'UDP',\ 'TCP\/UDP'/'TCP',\ 'UDP',\ 'BOTH'/g" ${D}/usr/www/actionHandler/ajax_managed_services.php
    sed -i '/Security.X_COMCAST-COM_KeyPassphrase/a \
    \t\t\tsetStr("Device.DeviceInfo.X_RDKCENTRAL-COM_ConfigureWiFi", "false", true);' ${D}/usr/www/actionHandler/ajaxSet_wireless_network_configuration_redirection.php
	sed -i -e "s/https:\/\/webui-xb3-cpe-srvr.xcal.tv/http:\/\/'.\$ip_addr.'/g" ${D}/usr/www/index.php
	sed -i -e "s/LIGHTTPD_PID=\`pidof lighttpd\`/LIGHTTPD_PID=\`pidof lighttpd php-cgi\`/g" ${D}${sysconfdir}/webgui.sh
	sed -i -e "s/\/bin\/kill \$LIGHTTPD_PID/\/bin\/kill -9 \$LIGHTTPD_PID/g" ${D}${sysconfdir}/webgui.sh
        #Remove Mesh-Mode Validation on RPI
        sed -i -e "s/&& (\$Mesh_Mode==\"false\")//g" ${D}/usr/www/actionHandler/ajaxSet_wireless_network_configuration_edit.php
	sed -i "/setting ConfigureWiFi to true/a echo \"}\" >> \$LIGHTTPD_CONF" ${D}${sysconfdir}/webgui.sh
	sed -i "/setting ConfigureWiFi to true/a echo \"}\" >> \$LIGHTTPD_CONF" ${D}${sysconfdir}/webgui.sh
	sed -i "/setting ConfigureWiFi to true/a echo \"\\\\\$HTTP[\\\\\"host\\\\\"] !~ \\\\\":8080\\\\\" {  \\\\\$HTTP[\\\\\"url\\\\\"] !~ \\\\\"captiveportal.php\\\\\" {  \\\\\$HTTP[\\\\\"referer\\\\\"] == \\\\\"\\\\\" { url.redirect = ( \\\\\".*\\\\\" => \\\\\"http://10.0.0.1/captiveportal.php\\\\\" ) url.redirect-code = 303 }\" >> \$LIGHTTPD_CONF"  ${D}${sysconfdir}/webgui.sh
	sed -i "/setting ConfigureWiFi to true/a                          sed -i \'\/server.modules              = \(\/a \"mod_rewrite\",' \$LIGHTTPD_CONF" ${D}${sysconfdir}/webgui.sh
	sed -i "/setting ConfigureWiFi to true/a sed -i \'\/server.modules              = \(\/a \"mod_redirect\",' \$LIGHTTPD_CONF" ${D}${sysconfdir}/webgui.sh
        sed -i "s/if((!strcmp(\$url, \$Wan_IPv4) || ((inet_pton(\$url)!=\"\") || (inet_pton(\$Wan_IPv6!==\"\"))) &&(inet_pton(\$url) == inet_pton(\$Wan_IPv6)))){/if(!strcmp(\$url, \$Wan_IPv4) || (inet_pton(\$url) == inet_pton(\$Wan_IPv6))){/g" ${D}/usr/www/index.php
	install -m 755 ${WORKDIR}/CcspWebUI.sh ${D}${base_libdir}/rdk/
	install -m 644 ${WORKDIR}/CcspWebUI.service ${D}${systemd_unitdir}/system/
	############# EthWan Support
        sed -i "/jProgress/a alert(\'DOCSIS Support is not available in RPI Boards\'); die();" ${D}/usr/www/wan_network.php
        sed -e '/jProgress/ s/^/\/\//' -i ${D}/usr/www/wan_network.php
        sed -i "s/\$clients_RSSI\[strtoupper(\$Host\[\"\$i\"\]\['PhysAddress'\])\]/\$Host\[\$i\]\['X_CISCO_COM_RSSI'\]/g" ${D}/usr/www/connected_devices_computers.php
	sed -i "s/if ((\$bridge_mode == \"bridge-static\") || (\$modelName!=\"CGM4140COM\") ) {/if ((\$bridge_mode == \"bridge-static\") \&\& (\$modelName!=\"CGM4140COM\") ) {/g" ${D}/usr/www/wan_network.php
	sed -i "s/\$wnStatus= (\$wan_enable==\"true\" \&\& \$wan_status==\"Down\") ? \"true\" : \"false\";/\$wnStatus= (\$wan_enable==\"true\" \&\& \$wan_status==\"Up\") ? \"true\" : \"false\";/g" ${D}/usr/www/wan_network.php
	sed -i "s/if(isset(\$locale) \&\& \!strstr(\$locale\, 'en')) {/if(isset(\$locale) \&\& strstr(\$locale\, 'en')) {/g" ${D}/usr/www/includes/header.php

	#Backup and Restore feature related
	install -m 755 ${S}/../../scripts/confPhp ${D}/lib/rdk/
	install -m 0755 ${S}/../../../sysint/devicerpi/Backup_Restore/backup_user_settings.php ${D}/usr/www/
	install -m 0755 ${S}/../../../sysint/devicerpi/Backup_Restore/download_user_settings.php ${D}/usr/www/
	install -m 0755 ${S}/../../../sysint/devicerpi/Backup_Restore/upload_user_settings1.php ${D}/usr/www/
	install -m 0755 ${S}/../../../sysint/devicerpi/Backup_Restore/upload_user_settings2.php ${D}/usr/www/
	install -m 0755 ${S}/../../../sysint/devicerpi/Backup_Restore/backup_enc_key.php ${D}/usr/www/
	install -m 0755 ${S}/../../../sysint/devicerpi/Backup_Restore/ajax_at_saving_backup_key.php ${D}/usr/www/actionHandler/

	#Encryption and decryption of database files
	sed -i "/rm \/nvram\/db_version/d" ${D}/lib/rdk/confPhp
	sed -i "/tar -cvf/c\ \ttar -cvf \"\$1\" \/nvram\/syscfg.enc \/nvram\/bbhm_cur_cfg.enc \/nvram\/bbhm_bak_cfg.enc \/nvram\/hostapd0.enc \/nvram\/hostapd1.enc" ${D}/lib/rdk/confPhp
	sed -i "/tar -cvf/a \ \trm \/nvram\/db_version \/nvram\/syscfg.enc \/nvram\/bbhm_cur_cfg.enc \/nvram\/bbhm_bak_cfg.enc \/nvram\/hostapd0.enc \/nvram\/hostapd1.enc" ${D}/lib/rdk/confPhp
	sed -i "/mv \/nvram\/bbhm_bak_cfg.xml \/nvram/a \ \tmv \/nvram\/hostapd0.conf \/nvram\/hostapd0.conf.prev \ \n \tmv \/nvram\/hostapd1.conf \/nvram\/hostapd1.conf.prev" ${D}/lib/rdk/confPhp
	sed -i "/mv \/nvram\/bbhm_bak_cfg.xml.prev \/nvram/a \ \t \tmv \/nvram\/hostapd0.conf.prev \/nvram\/hostapd0.conf \ \n \t \tmv \/nvram\/hostapd1.conf.prev \/nvram\/hostapd1.conf" ${D}/lib/rdk/confPhp
	sed -i "/echo \"CONF_RECOVER_STATUS_NEED_REBOOT\"/s/^/#/" ${D}/lib/rdk/confPhp
	sed -i "/moca_diagnostics.php/a \ \t\techo '<li class=\"nav-backup-user\"><a role=\"\menuitem\"  href=\"\backup_user_settings.php\">Backup User Settings</a></li>\';" ${D}/usr/www/includes/nav.php
	sed -i "/checkForRebooting()/i \ \nfunction popUp(URL) { \n \ \t \t day = new Date(); \n \ \t \t id = day.getTime(); \n \ \t \t eval(\"\page\" + id + \"\ = window.open(URL, \'\"\ + id + \"\', \'toolbar=0,scrollbars=0,location=0,statusbar=0,menubar=0,resizable=0,width=700,height=400,left = 320.5,top = 105\');\"); \n }\n" ${D}/usr/www/restore_reboot.php
	sed -i "/<\/\div> <!-- end .module -->/i \ \n \t \t<div id=\"\div7\" class=\"form-row\"> \ \n \t \t \t<span class=\"readonlyLabel\"><a href=\"\#\" class=\"\btn\" id=\"\btn7\" onClick=\"\javascript:popUp(\'upload_user_settings1.php\')\" title=\"\Restore User settings\" style=\"text-transform : none;\">RESTORE USER SETTINGS<\/a><\/\span> \ \n \t \t \t<span class=\"value\">Press \"Restore User Settings\" to restore saved user <span style=\"padding-left:231px\">settings. All your current settings will be lost. <\/\span><\/\span> \ \n \t \t<\/\div>" ${D}/usr/www/restore_reboot.php

}
do_install_append_morty () {
    #Locate svg file to load
    echo  "<?php \n\$files = glob('/run/log/bootchart-[0-9]*?-[0-9]*?.svg');\necho file_get_contents(\$files[0]);\n?>" > ${D}/usr/www/bootchart.php

    #Include bootchart.php in nav.php
   sed -i "/password_change.php/a echo '<li class="nav-bootchart"><a role="menuitem"  href="bootchart.php">Bootchart</a></li>';" ${D}/usr/www/includes/nav.php
}

SYSTEMD_SERVICE_${PN} += "CcspWebUI.service"
FILES_${PN} += "${sysconfdir}/php.ini ${systemd_unitdir}/system/CcspWebUI.service"
