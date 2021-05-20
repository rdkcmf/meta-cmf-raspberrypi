do_install_append() {
        install -d ${D}${includedir}/gstreamer-1.0/gst/playback/
        install -m 644 ${S}/gst/playback/gstplay-enum.h ${D}${includedir}/gstreamer-1.0/gst/playback/gstplay-enum.h
}

PACKAGECONFIG_GL_VC4GRAPHICS = "${@bb.utils.contains('DISTRO_FEATURES', 'opengl', 'gles2 egl', '', d)}"
PACKAGECONFIG_GL_rpi = "${@bb.utils.contains('MACHINE_FEATURES', 'vc4graphics', '${PACKAGECONFIG_GL_VC4GRAPHICS}', 'egl gles2', d)}"
