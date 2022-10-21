FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"
                     
SRC_URI +="${@bb.utils.contains('DISTRO_FEATURES', 'webconfig_bin', 'file://webconfig_metadata_json_rpi_entry.patch;apply=no', '', d)}"
do_rpi_patches () {
    cd ${WORKDIR}
    if [ ! -e rpi_patch_applied ]; then
       patch < webconfig_metadata_json_rpi_entry.patch
       touch rpi_patch_applied
    fi
}
addtask rpi_patches after do_configure before do_compile
