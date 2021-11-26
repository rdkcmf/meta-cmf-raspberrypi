DEPENDS_remove = "hdmicec"
DEPENDS += "netsrvmgr"

EXTRA_OECMAKE_remove = "-DHAS_API_HDMI_CEC=ON"
EXTRA_OECMAKE += " \
    -DBUILD_RASPBERRYPI=ON \
    -DSVCMGR_PLATFORM_SOC=common \
    -DBUILD_DBUS=ON \
    -DBUILD_ENABLE_WIFI_MANAGER=ON \
    -DSECAPI_LIB= \
    -DCONTINUEWATCHING_DISABLE_SECAPI=ON \
    -DBUILD_ENABLE_THERMAL_PROTECTION=ON \
    "
MONITOR_PLUGIN_ARGS += " \
    -DPLUGIN_MONITOR_WEBKITBROWSER=ON \
    -DPLUGIN_MONITOR_WEBKITBROWSER_MEMORYLIMIT=614400 \
    -DPLUGIN_MONITOR_WEBKITBROWSER_YOUTUBE=ON \
    -DPLUGIN_MONITOR_COBALT_MEMORYLIMIT=614400 \
    -DPLUGIN_MONITOR_COBALT=ON \
    -DPLUGIN_MONITOR_YOUTUBE_MEMORYLIMIT=614400 \
    -DPLUGIN_MONITOR_WEBKITBROWSER_APPS=ON \
    -DPLUGIN_MONITOR_APPS_MEMORYLIMIT=614400 \
    -DPLUGIN_MONITOR_OUTOFPROCESS=ON \
    -DPLUGIN_MONITOR_WEBKITBROWSER_RESIDENT_APP=ON \
    -DPLUGIN_MONITOR_RESIDENT_APP_MEMORYLIMIT=614400 \
    "

# this is temporary fix till https://github.com/rdkcentral/rdkservices/pull/591
# is part of rdkservices and the revision included in the build
CXXFLAGS += "-DENABLE_THERMAL_PROTECTION"

# This flag make work get reboot info APIs in System services
CXXFLAGS += "-DPLATFORM_BROADCOM_REF"

PACKAGECONFIG_remove = "controlservice hdmicec remoteactionmapping \
                        securityagent opencdmi datacapture"
# displayinfo is temporarily not supported for RPi until fixes are being in main branch
PACKAGECONFIG_remove = "displayinfo"

FILESEXTRAPATHS_prepend := "${THISDIR}/files:"
SRC_URI_append = " \
file://0001-added-source-code-changes-for-systemservice-for-fwup.patch  \
"
