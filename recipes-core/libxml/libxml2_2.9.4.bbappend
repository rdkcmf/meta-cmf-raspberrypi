export HOST_SYS
export BUILD_SYS
export STAGING_LIBDIR
export STAGING_INCDIR

inherit distutils-common-base

do_install_append() {
    install -d ${D}${includedir}
    install -d ${D}${includedir}/libxml

    install -m 0644 ${S}/include/libxml/*.h  ${D}${includedir}/libxml/
}

FILES_${PN} += "${includedir}"
