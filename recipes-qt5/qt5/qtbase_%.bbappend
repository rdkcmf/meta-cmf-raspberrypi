PACKAGECONFIG_GL_remove_rpi = "${@bb.utils.contains('DISTRO_FEATURES', 'ipclient', ' kms', '', d)}"
