# RPi specifc changes for libcobalt 21.lts.stable
FILESEXTRAPATHS_append := ":${THISDIR}/${PN}"

# this patch is needed for cobalt to work in dunfell in rpi. Other boxes doesn't have this issue
# so this should be applied for 21.lts.stable for youtbe to work
SRC_URI_append_rpi = " file://0001-changes-for-wayland.patch"
