
FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

#seven inch display support for refapp

SRC_URI_append = "${@bb.utils.contains('DISTRO_FEATURES', 'seven-inch-display', ' file://appmanager-7inch-display-support.patch;apply=no ', '', d)}"

# we need to patch to code for RPi
do_rpi_patches() {
    cd ${S}
    if [ ! -e patch_applied_rpi ]; then
        if [ -f ${WORKDIR}/appmanager-7inch-display-support.patch ]; then
            patch -p1 < ${WORKDIR}/appmanager-7inch-display-support.patch
            touch patch_applied_rpi
        fi
    fi
}
addtask rpi_patches after do_unpack before do_compile

do_install_append_rpi(){
    sed -i -e '/ConditionPathExists/d' ${D}${systemd_unitdir}/system/appmanager.service
    if [ "${@is_spark_disabled(d)}" -eq '0' ]
    then
        sed -i  '/else if (e.keyCode == keys.M && keys.is_CTRL( e.flags ))/c\ \ \ \ \ \ \ \else if ((e.keyCode == keys.G) || (e.keyCode == 29))' ${D}/home/root/startup_partnerapp.js
    fi

    # enable WESTEROSSINK for AAMP on refapp builds
    if [ "${@bb.utils.contains("DISTRO_FEATURES", "refapp", "yes", "no", d)}" = "yes" ]; then
        sed -i  '/PLAYERSINKBIN_USE_WESTEROSSINK/iexport AAMP_ENABLE_WESTEROS_SINK=1' ${D}/lib/rdk/runAppManager.sh
    fi
}
