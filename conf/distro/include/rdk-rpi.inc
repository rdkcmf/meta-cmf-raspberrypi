IMAGE_GEN_DEBUGFS = "0"

### preferred providers
PREFERRED_PROVIDER_libevent = "libevent"

PREFERRED_PROVIDER_virtual/iarmmgrs-hal = "iarmmgrs-hal-raspberrypi"
PREFERRED_PROVIDER_virtual/devicesettings-hal = "devicesettings-hal-raspberrypi"
PREFERRED_PROVIDER_virtual/gst-plugins-playersinkbin ?= "gst-plugins-playersinkbin-rpi"
PREFERRED_PROVIDER_virtual/wifi-hal ?= "wifi-client-hal-raspberrypi"
PREFERRED_PROVIDER_virtual/mfrlib ?= "mfrlibs-rpi"
PREFERRED_PROVIDER_virtual/mfrfwlib ?= "fwupgrade-lib"

VIRTUAL-RUNTIME_mfrlib = "mfrlibs-rpi"
VIRTUAL-RUNTIME_dtcpmgr = ""

DISTRO_FEATURES_append = " streamfs"

DISTRO_FEATURES_append = " parodus"
DISTRO_FEATURES_append = " ledmgr"
DISTRO_FEATURES_append = " build_rne"
DISTRO_FEATURES_append = " rdk-oss-ssa"

DISTRO_FEATURES_append = " ctrlm"
DISTRO_FEATURES_append = " ctrlm_voice_sdk"
DISTRO_FEATURES_append = " blercudaemon"

# CMFSUPPORT-897 Rialto recipes in meta-cmf-video
DISTRO_FEATURES_append = " rialto"

# Disable Thunder Security
DISTRO_FEATURES_append = " thunder_security_disable"

DISTRO_FEATURES_append = " enable_icrypto_openssl"
DISTRO_FEATURES_remove = "netflix_cryptanium"

# OCDM CAS support
DISTRO_FEATURES_append = " external-cas"

# APPARMOR support
DISTRO_FEATURES_append = " apparmor"

# Containerization support
DISTRO_FEATURES_append = " DOBBY_CONTAINERS build_rfc_enabled"

# Turn ON and OFF the hardening feature.
DISTRO_FEATURES_NATIVE_append=" harden_dobby"

HOSTTOOLS += " python python2.7"

# globally disables this feature (for all images supported)
IMAGE_FEATURES_remove = "read-only-rootfs"

# Upgrade wpe-webkit to 2.28
# The WEBBACKENDS will be migrated to meta-rdk when all other platforms have moved to a later version of wpe-webkit, e.g. 2.38
DISTRO_FEATURES_append = " wpe-2.28"
WEBBACKENDS := "${@bb.utils.contains('DISTRO_FEATURES', 'wpe-2.28', 'webkitbrowser-plugin', 'rdkbrowser2', d)}"

GST_VERSION_morty = "1.10.4"
GST_VERSION_dunfell = "1.16.%"

PREFERRED_VERSION_gstreamer1.0-libav_dunfell = "1.14.1"

PREFERRED_VERSION_xfsprogs_krogoth = "3.2.3"

PREFERRED_VERSION_libwebp_morty = "0.5.1"

PREFERRED_VERSION_linux-raspberrypi_morty = "4.14.%"

PREFERRED_VERSION_wayland_morty = "1.11%"
PREFERRED_VERSION_wayland-native_morty = "1.11%"

### others
ENABLE_UART = "1"

# RDKBDEV-298 : Add USP Agent support using OBUSPA
DISTRO_FEATURES_append = " usppa"

# REFPLTV-1137: DLNA support for xupnp
DISTRO_FEATURES_append = " dlna"

DISTRO_FEATURES_append = " webconfig_bin"

DISTRO_FEATURES_append = " rdkb_cellular_manager"
DISTRO_FEATURES_append = " rdkb_power_manager"
DISTRO_FEATURES_append = " rdkb_gpon_manager"
DISTRO_FEATURES_append = " rdkb_wan_manager"
DISTRO_FEATURES_append = " rdkb_voice_manager_dmltr104_v2"
DISTRO_FEATURES_append = " rdkb_xdsl_ppp_manager"
DISTRO_FEATURES_append = " fwupgrade_manager"

# RDKBDEV-50: Adding DSLite Functionality and related TR-181 DataModel Parameters
DISTRO_FEATURES_append = " dslite"

# RDKBDEV-73 : Dynamic DNS : Standardization based on broadband-forum.
DISTRO_FEATURES_append = " ddns_broadband"

# RDKBDEV-83 : Device Gateway Association using Managed Device
DISTRO_FEATURES_append = " device_gateway_association"

# REFPLTB-1546 : WiFi HAL 3.0 support for RPI
DISTRO_FEATURES_append = " halVersion3"

# RDKBDEV-866: EasyMesh Controller support
DISTRO_FEATURES_append = " easymesh-controller"

# RDKB-40900: RDKB support extender/nonrouter profile
DISTRO_FEATURES_append = " rdkb_extender"

# RDKB-44824: CoreNetLib move bb file location
DISTRO_FEATURES_append = " core-net-lib"

SESSIONMGR_WS_RPC_ENABLE = "1"
