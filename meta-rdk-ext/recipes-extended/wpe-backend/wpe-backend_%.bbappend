DEPENDS += "virtual/egl"

# for vc4graphics, wayland expects this flag
CXXFLAGS += "${@bb.utils.contains('MACHINE_FEATURES', 'vc4graphics', \
                bb.utils.contains('DISTRO_FEATURES', 'wayland', '-DWL_EGL_PLATFORM', '', d), \
                '', d)}"
