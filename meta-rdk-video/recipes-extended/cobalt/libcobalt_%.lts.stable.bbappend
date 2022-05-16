# RPi specifc changes for libcobalt x.lts.stable, where x can be 21, 22, ...
FILESEXTRAPATHS_append := ":${THISDIR}/${PN}"

# this patch is needed for cobalt to work in dunfell in rpi. Other boxes doesn't have this issue
# so this should be applied for x.lts.stable for youtbe to work
SRC_URI_append_rpi_dunfell = " file://0001-changes-for-wayland.patch"
