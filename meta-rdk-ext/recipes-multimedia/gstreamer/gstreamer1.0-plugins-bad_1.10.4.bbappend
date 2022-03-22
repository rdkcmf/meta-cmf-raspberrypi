#
FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

# to avoid "no rule to make target viewporter-protocols.c" error on enabling wayland
# this patch may come in meta-wpe as well, such case also to be taken care
SRC_URI_append = " \
    file://0001-use-PKG_CHECK_VAR-for-defining-WAYLAND_PROTOCOLS_DAT.patch \
"

EXTRA_OEMAKE += "WAYLAND_PROTOCOLS_DATADIR=${STAGING_DATADIR}/wayland-protocols"

SRC_URI_remove = "file://0004-Fix-to-set-current_fragment-for-live-streaming.patch "

FILES_${PN} += "/usr/lib/gstreamer-1.0/include /usr/lib/gstreamer-1.0/include/gst /usr/lib/gstreamer-1.0/include/gst/gl /usr/lib/gstreamer-1.0/include/gst/gl/gstglconfig.h"

PACKAGECONFIG_remove = "faad"
