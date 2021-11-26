FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI_append_raspberrypi4-5.10 += " file://include_proc_ops.patch"
SRC_URI_append_aarch64 = " file://include_proc_ops.patch"
