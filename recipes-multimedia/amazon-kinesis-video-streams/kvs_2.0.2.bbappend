
FILESEXTRAPATHS_prepend := "${THISDIR}/files:"
		
SRC_URI += "file://kvs_crash.patch;apply=no \
           "
	
do_kvs_patches() {
    cd ${S}
    if [ ! -e patch_applied ]; then
        patch -p1 < ${WORKDIR}/kvs_crash.patch
        touch patch_applied
    fi
}
		
addtask kvs_patches after do_unpack before do_compile
	
TARGET_CFLAGS_append_rpi += "-DKVS_PLATFORM_RPI"
