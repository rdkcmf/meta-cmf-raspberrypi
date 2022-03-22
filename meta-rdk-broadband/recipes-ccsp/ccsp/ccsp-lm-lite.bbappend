require ccsp_common_rpi.inc

LDFLAGS_append = " -Wl,--no-as-needed"

FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://Temp_fix_for_ConnectedDevices_updateonWebUI.patch;apply=no"

# we need to patch to code for ccsp-lm-lite
do_rpi_ccsplmlite_patches() {
    cd ${S}
    if [ ! -e patch_applied ]; then
        bbnote "Patching Temp_fix_for_ConnectedDevices_updateonWebUI.patch"
        patch -p1 < ${WORKDIR}/Temp_fix_for_ConnectedDevices_updateonWebUI.patch
        touch patch_applied
    fi
}
addtask rpi_ccsplmlite_patches after do_unpack before do_configure
