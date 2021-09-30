PACKAGECONFIG_remove = " playready provisioning"

DEPENDS += "atk libgcrypt libwebp"

PACKAGECONFIG_append_rpi = " rpi"

PACKAGECONFIG[rpi] = "-DUSE_WPEWEBKIT_BACKEND_BCM_RPI=ON,,"

EXTRA_OECMAKE += "${@bb.utils.contains('WPE_BACKEND', 'gstreamergl', '-DUSE_KEY_INPUT_HANDLING_LINUX_INPUT=ON', '', d)}"

RDEPS_EXTRA += " \
    gstreamer1.0-plugins-bad-hls \
    shared-mime-info \
    wpe-webkit-web-inspector-plugin \
    libgpg-error \
    tts \
"

RDEPS_EXTRA_append_rpi = " \
    ${@bb.utils.contains('MACHINE_FEATURES', 'vc4graphics', 'gstreamer1.0-plugins-good-video4linux2 ', '', d)} \
    ${@bb.utils.contains('MACHINE_FEATURES', 'vc4graphics', '', 'gstreamer1.0-omx', d)} \
"

RDEPS_EXTRA_append_morty = " \
    gstreamer1.0-plugins-bad-faad \
    gstreamer1.0-plugins-bad-opengl \
    gstreamer1.0-plugins-ugly-mpg123 \
"

RDEPS_EXTRA_append_dunfell = " \
    ${@bb.utils.contains('LICENSE_FLAGS_WHITELIST', 'commercial', 'gstreamer1.0-plugins-bad-faad', '', d)} \
    gstreamer1.0-plugins-base-opengl \
    gstreamer1.0-plugins-good-mpg123 \
"

# RDK Distro excludes shared-mime-info for dunfell builds
RDEPS_EXTRA_remove_dunfell = " \
    shared-mime-info \
    gstreamer1.0-plugins-bad-dataurisrc \
"

RDEPS_EXTRA_remove_daisy = "gstreamer1.0-plugins-ugly-mpg123"