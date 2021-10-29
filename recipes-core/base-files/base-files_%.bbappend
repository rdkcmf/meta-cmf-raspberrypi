# RPi environment variables
do_install_append_client () {
    set_playback_environment
}

do_install_append_hybrid () {
    set_playback_environment
}

do_install_append_raspberrypi4 () {
    echo "export WESTEROS_DRM_CARD=/dev/dri/card1" >> ${D}${sysconfdir}/profile
}

#rmfapp faces network error when httpsrc is used on hnsource
#setting the environment to choose souphttpsrc instead of httpsrc in hnsource
do_install_append_dunfell() {
        cat >> ${D}${sysconfdir}/profile <<EOF
export RMF_USE_SOUPHTTPSRC=TRUE
EOF
}

set_playback_environment() {
    if ${@bb.utils.contains('MACHINE_FEATURES', 'vc4graphics', 'true', 'false', d)}; then
        cat >> ${D}${sysconfdir}/profile <<EOF
export LD_PRELOAD=/usr/lib/libwesteros_gl.so.0
export WESTEROS_SINK_USE_FREERUN=1
EOF
    else
        cat >> ${D}${sysconfdir}/profile <<EOF
export LD_PRELOAD=/usr/lib/libopenmaxil.so:/usr/lib/libwayland-client.so.0
EOF
    fi
#rmfapp video is playing only in /tmp for dunfell builds whereas rmfapp video is playing for both
#/tmp and /run directories for morty builds. Hence keeping tmp/ as common for both builds.
        cat >> ${D}${sysconfdir}/profile <<EOF
export XDG_RUNTIME_DIR=/tmp
export WAYLAND_DISPLAY=wayland-0
export PLAYERSINKBIN_USE_WESTEROSSINK=1
export AAMP_ENABLE_WESTEROS_SINK=1
EOF
}
