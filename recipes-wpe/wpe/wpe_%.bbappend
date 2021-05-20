FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI_append_krogoth = " \
    file://0001-added-IR-keymap-for-linux-input.patch \
"

WPE_BACKEND = "${@bb.utils.contains('DISTRO_FEATURES', 'wayland', 'rpi', '', d)}"

PROVISIONING = ""

RDEPS_EXTRA_remove_krogoth = "gstreamer1.0-plugins-ugly-mpg123"
RDEPS_EXTRA_remove_krogoth = "gstreamer1.0-plugins-bad-hls"
RDEPS_EXTRA_krogoth += "gstreamer1.0-plugins-bad-mpg123"
RDEPS_EXTRA_krogoth += "gstreamer1.0-plugins-bad-fragmented"
