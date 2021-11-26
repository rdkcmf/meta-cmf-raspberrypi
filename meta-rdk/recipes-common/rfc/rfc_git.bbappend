do_install_append() {
        #Set the RFC_CONFIG_SERVER_URL by sed 
        sed -i '/RFC_CONFIG_SERVER_URL/c\RFC_CONFIG_SERVER_URL= Content you want to replace' ${D}${sysconfdir}/rfc.properties
        sed -i 's/export RFC_RAM_PATH/RFC_RAM_PATH/g' ${D}${sysconfdir}/rfc.properties
        sed -i 's/export RFC_LIST_FILE_NAME_PREFIX/RFC_LIST_FILE_NAME_PREFIX/g' ${D}${sysconfdir}/rfc.properties
        sed -i 's/export RFC_LIST_FILE_NAME_SUFFIX/RFC_LIST_FILE_NAME_SUFFIX/g' ${D}${sysconfdir}/rfc.properties
        sed -i 's/export RFC_PATH/RFC_PATH/g' ${D}${sysconfdir}/rfc.properties
        sed -i '/getaccountid.sh/ s/^/#/g' ${D}${base_libdir}/rdk/RFCbase.sh
        sed -i '/getPartnerId.sh/ s/^/#/g' ${D}${base_libdir}/rdk/RFCbase.sh
        sed -i '/getPartnerId.sh/ a\   echo " "' ${D}${base_libdir}/rdk/RFCbase.sh
	#Remove forcing https
        sed -i '/force https/{n;s/^/#/g}' ${D}${base_libdir}/rdk/RFCbase.sh
        sed -i 's/Waiting 2 minutes before attempting to query xconf/Waiting 10 seconds before attempting to query xconf/g' ${D}${base_libdir}/rdk/RFCbase.sh
        sed -i '/sleep  120/c\sleep  10' ${D}${base_libdir}/rdk/RFCbase.sh
        sed -i '/rfcLogging "ERROR configuring RFC location NewLoc=$RFC_BASE, no parent folder"/ a mkdir -p $RFC_BASE ; mkdir -p $RFC_PATH' ${D}${base_libdir}/rdk/RFCbase.sh
}

