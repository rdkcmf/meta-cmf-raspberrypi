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

DISTRO_FEATURES_append = " parodus"
DISTRO_FEATURES_append = " ledmgr"
DISTRO_FEATURES_append = " build_rne"

DISTRO_FEATURES_append = " ctrlm"
DISTRO_FEATURES_append = " ctrlm_voice_sdk"

# Disable Thunder Security
DISTRO_FEATURES_append = " thunder_security_disable"

DISTRO_FEATURES_append = " enable_icrypto_openssl"
DISTRO_FEATURES_remove = "netflix_cryptanium"

# globally disables this feature (for all images supported)
IMAGE_FEATURES_remove = "read-only-rootfs"

### preferred versions
GCCVERSION_daisy = "6.4%"

# gstreamer preferred versions
GST_VERSION_krogoth = "1.6.3"
PREFERRED_VERSION_gstreamer1.0-plugins-ugly_krogoth = "1.6.3"
PREFERRED_VERSION_gstreamer1.0-omx_krogoth = "1.2.0"

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
DISTRO_FEATURES_append = " usppa"

SESSIONMGR_WS_RPC_ENABLE = "1"
