FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

#Broadband
SRC_URI_append = "${@bb.utils.contains('DISTRO_FEATURES', 'lxc-secure-containers-br', ' file://xml/lxc_conf_CcspPandMSsp.xml ', '', d)}"
SRC_URI_append = "${@bb.utils.contains('DISTRO_FEATURES', 'lxc-secure-containers-br', ' file://xml/lxc_conf_DBUS.xml ', '', d)}"
SRC_URI_append = "${@bb.utils.contains('DISTRO_FEATURES', 'lxc-secure-containers-br', ' file://xml/lxc_conf_CcspCrSsp.xml ', '', d)}"
SRC_URI_append = "${@bb.utils.contains('DISTRO_FEATURES', 'lxc-secure-containers-br', ' file://xml/lxc_conf_Psm.xml ', '', d)}"
SRC_URI_append = "${@bb.utils.contains('DISTRO_FEATURES', 'lxc-secure-containers-br', ' file://xml/lxc_conf_CcspWiFi.xml ', '', d)}"
SRC_URI_append = "${@bb.utils.contains('DISTRO_FEATURES', 'lxc-secure-containers-br', ' file://xml/lxc_conf_CcspLMLite.xml ', '', d)}"


do_install_append () {

#Broadband
	${@bb.utils.contains('DISTRO_FEATURES', 'lxc-secure-containers-br', ' install_lxc_config secure lxc_conf_CcspPandMSsp.xml ', '', d)}
	${@bb.utils.contains('DISTRO_FEATURES', 'lxc-secure-containers-br', ' install_lxc_config secure lxc_conf_CcspCrSsp.xml ', '', d)}
	${@bb.utils.contains('DISTRO_FEATURES', 'lxc-secure-containers-br', ' install_lxc_config secure lxc_conf_DBUS.xml ', '', d)}
	${@bb.utils.contains('DISTRO_FEATURES', 'lxc-secure-containers-br', ' install_lxc_config secure lxc_conf_Psm.xml ', '', d)}
	${@bb.utils.contains('DISTRO_FEATURES', 'lxc-secure-containers-br', ' install_lxc_config secure lxc_conf_CcspWiFi.xml ', '', d)}
	${@bb.utils.contains('DISTRO_FEATURES', 'lxc-secure-containers-br', ' install_lxc_config secure lxc_conf_CcspLMLite.xml ', '', d)}
}
