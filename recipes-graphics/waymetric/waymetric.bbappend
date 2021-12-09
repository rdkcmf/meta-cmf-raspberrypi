DEPENDS += "${@bb.utils.contains('DISTRO_FEATURES', 'dunfell', ' libdrm mesa', ' userland', d)}"

CXXFLAGS_append = "${@bb.utils.contains('DISTRO_FEATURES', 'dunfell', ' -DUSE_PLATFORM_DRM -I${STAGING_INCDIR}/libdrm', ' -DUSE_PLATFORM_USERLAND', d)}"

LDFLAGS_append = "${@bb.utils.contains('DISTRO_FEATURES', 'dunfell', ' -ldrm -lgbm -ldl -lwayland-server', '  -lbcm_host -lvchostif -lwayland-server', d)}"

CXXFLAGS_append_dunfell = " ${@bb.utils.contains('MACHINE_FEATURES', 'vc4graphics', '-DUSE_MESA', '', d)}"
