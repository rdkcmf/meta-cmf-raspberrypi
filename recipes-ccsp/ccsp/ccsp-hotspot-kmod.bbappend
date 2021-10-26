FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI_append_raspberrypi4-5.10 += " file://include_proc_ops.patch"
