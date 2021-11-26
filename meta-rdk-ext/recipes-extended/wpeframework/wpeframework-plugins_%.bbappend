FILESEXTRAPATHS_prepend := "${THISDIR}/files:"
PLUGIN_WEBSERVER_PORT = "7070"
WEBKITBROWSER_STARTURL = "http://localhost:7070/RDKSplashScreen/index.html"

inherit coverity

PACKAGECONFIG_remove = "opencdmi_pr"
PACKAGECONFIG_remove = "opencdmi_wv"

WPE_SNAPSHOT_DEP_remove_rpi = "${@bb.utils.contains('MACHINE_FEATURES', 'vc4graphics', 'userland', '', d)}"
WPE_SNAPSHOT_DEP_rpi = "${@bb.utils.contains('MACHINE_FEATURES', 'vc4graphics', '', 'userland', d)}"

PACKAGECONFIG[firmwarecontrol] = "-DPLUGIN_FIRMWARECONTROL=ON,-DPLUGIN_FIRMWARECONTROL=OFF,"

SPARK_PLATFORM = "-DPLATFORM_ESSOS=ON"
