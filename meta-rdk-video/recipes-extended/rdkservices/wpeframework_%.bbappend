FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI += "file://rdkshell_keymapping.json \
            file://wpeframework.conf \
            file://cardselect_rpi4.sh \
           "

do_install_append(){
    install -d ${D}${systemd_unitdir}/system/wpeframework.service.d
    install -D -m 0644 ${WORKDIR}/rdkshell_keymapping.json  ${D}${sysconfdir}
    install -D -m 0644 ${WORKDIR}/wpeframework.conf ${D}${systemd_unitdir}/system/wpeframework.service.d/
}

do_install_append_raspberrypi4() {
    echo "Environment=\"WESTEROS_DRM_CARD=/dev/dri/card1\"" >> ${D}${systemd_unitdir}/system/wpeframework.service.d/wpeframework.conf
    echo "WESTEROS_DRM_CARD=/dev/dri/card1" >> ${D}${sysconfdir}/wpeframework/WPEFramework.env
    sed -i '/^ExecStart=.*/i ExecStartPre=-/lib/rdk/cardselect_rpi4.sh' ${D}${systemd_unitdir}/system/wpeframework.service
    install -Dm755 ${WORKDIR}/cardselect_rpi4.sh ${D}${base_libdir}/rdk/cardselect_rpi4.sh
}

do_install_append_dunfell() {
    if ${@bb.utils.contains('MACHINE_FEATURES', 'vc4graphics', 'true', 'false', d)}; then
        echo "Environment=\"WESTEROS_SINK_USE_FREERUN=1\"" >> ${D}${systemd_unitdir}/system/wpeframework.service.d/wpeframework.conf
        echo "Environment=\"WESTEROS_GL_USE_GENERIC_AVSYNC=1\"" >> ${D}${systemd_unitdir}/system/wpeframework.service.d/wpeframework.conf
    fi
    echo "RDKSHELL_COMPOSITOR_TYPE=surface" >> ${D}${sysconfdir}/wpeframework/WPEFramework.env
}

FILES_${PN} += "${systemd_unitdir}/system/wpeframework.service.d/wpeframework.conf"
FILES_${PN} += "${sysconfdir}/rdkshell_keymapping.json"
FILES_${PN}_append_raspberrypi4 += "${base_libdir}/rdk/cardselect_rpi4.sh"
