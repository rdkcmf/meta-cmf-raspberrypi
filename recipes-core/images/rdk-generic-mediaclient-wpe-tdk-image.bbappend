IMAGE_INSTALL_append = " \
   packagegroup-tdk \
   hdhomerun \
   rdkapps \
   parodus \
   tr69hostif \
   tr69agent \
"

IMAGE_INSTALL_remove = " \
    westeros-init \
    wpe-webkit-init \
"

PACKAGE_EXCLUDE_pn-rdk-generic-mediaclient-westeros-wpe-tdk-image = "${@bb.utils.contains('DISTRO_FEATURES','ENABLE_IPK','packagegroup-tdk','',d)}"

#REFPLTV-976 removing the Control Manager service, as feature not fully functional.
ROOTFS_POSTPROCESS_COMMAND += "remove_systemd_ctrlm_services; "

remove_systemd_ctrlm_services() {
                if [ ! -f ${IMAGE_ROOTFS}${sysconfdir}/systemd/system/multi-user.target.wants/ctrlm-main.service ]; then
                        rm -rf ${IMAGE_ROOTFS}${systemd_unitdir}/system/ctrlm-main.service
                fi

		if [ ! -f ${IMAGE_ROOTFS}${sysconfdir}/systemd/system/multi-user.target.wants/ctrlm-main.service ]; then
			rm -rf ${IMAGE_ROOTFS}${sysconfdir}/systemd/system/multi-user.target.wants/ctrlm-main.service
		fi
}
