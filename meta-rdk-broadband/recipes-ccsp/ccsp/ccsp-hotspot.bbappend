require ccsp_common_rpi.inc

FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://0001-REFPLTB-1602-observing-build-errors-for-ccsp-hotspot.patch;apply=no"

# we need to patch to code for ccsp-hotspot
do_rpi_ccsphotspot_patches() {
    cd ${S}
    if [ ! -e patch_applied ]; then
        bbnote "Patching 0001-REFPLTB-1602-observing-build-errors-for-ccsp-hotspot.patch"
        patch -p1 < ${WORKDIR}/0001-REFPLTB-1602-observing-build-errors-for-ccsp-hotspot.patch
        touch patch_applied
    fi
}
addtask rpi_ccsphotspot_patches after do_unpack before do_configure
