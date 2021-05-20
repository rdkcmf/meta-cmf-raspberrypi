DEPENDS += "freetype"

FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"
SRC_URI_append_morty = "\
    file://0013-Implement-triple-buffering-for-wayland.patch \
    file://0016-Allow-multiple-wayland-compositor-state-data-per-pro.patch \
"

CFLAGS_append = "\
    -I${PKG_CONFIG_SYSROOT_DIR}/usr/include/freetype2 \
    -I${PKG_CONFIG_SYSROOT_DIR}/usr/include/ \
    -I${S} \
    -I${S}/interface/khronos/include \
    -I${S}/interface/vcos/pthreads \
    -I${S}/host_applications/linux/libs/bcm_host/include \
    -I${S}/interface/vmcs_host/linux \
"

LDFLAGS_append = "\
    ${PKG_CONFIG_SYSROOT_DIR}/lib/libpthread.so.0 \
    -L${PKG_CONFIG_SYSROOT_DIR}/usr/lib \
    -L${PKG_CONFIG_SYSROOT_DIR}/lib \
"

do_compile_append(){
    oe_runmake -C ${S}/host_applications/linux/apps/hello_pi/libs/vgfont
}

do_install_append(){
    install -d ${D}${libdir}
    install -d ${D}${includedir}
    install -m 644 ${S}/host_applications/linux/apps/hello_pi/libs/vgfont/vgfont.h ${D}${includedir}
    install -m 644 ${S}/host_applications/linux/apps/hello_pi/libs/vgfont/libvgfont.a ${D}${libdir}
}

FILES_${PN}_append = "\
    ${includedir}/vgfont.h \
    ${libdir}/libvgfont.a \
"

# no EGL runtime providers for vc4graphics
RPROVIDES_${PN}_remove = "${@bb.utils.contains('MACHINE_FEATURES', 'vc4graphics', 'libegl', '', d)}"
