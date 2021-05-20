# RPi specifc changes for libcobalt 20.lts.stable
FILESEXTRAPATHS_append := ":${THISDIR}/${PN}"

# though this patch merged to source it is added on top of 21.lts.stable support
# so this should be applied for 20.lts.stable
SRC_URI_append_rpi = " file://0001-starboard-rpi-#if-macro-error-fix.patch;patchdir=../starboard"
