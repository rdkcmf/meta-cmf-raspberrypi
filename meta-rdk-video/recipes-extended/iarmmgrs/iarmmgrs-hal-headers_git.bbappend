FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI_append = " \
                file://0001-xfinity-and-exit-keymap.patch;apply=no \
               "
# this is a temporary fix until http://code.rdkcentral.com/r/49395
# got merged into rdk-next branch
do_install_append () {
    install -m 0644 ${S}/mfr/include/mfr_temperature.h ${D}${includedir}/rdk/iarmmgrs-hal
}

# we need to patch to code for RPi
do_rpi_patches() {
    cd ${S}
    if [ ! -e patch_applied ]; then
        patch -p1 < ${WORKDIR}/0001-xfinity-and-exit-keymap.patch
        touch patch_applied
    fi
}
addtask rpi_patches after do_unpack before do_compile
