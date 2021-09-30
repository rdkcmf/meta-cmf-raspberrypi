# for vc4graphics, wayland expects this flag
CXXFLAGS += "${@bb.utils.contains('MACHINE_FEATURES', 'vc4graphics', \
                bb.utils.contains('DISTRO_FEATURES', 'wayland', '-DWL_EGL_PLATFORM', '', d), \
                '', d)}"

PACKAGECONFIG[rpi] = " -DUSE_BACKEND_BCM_RPI=ON -DUSE_KEY_INPUT_HANDLING_LINUX_INPUT=ON -DUSE_GSTREAMER_GL=ON,-DUSE_GSTREAMER_GL=OFF,virtual/egl"
