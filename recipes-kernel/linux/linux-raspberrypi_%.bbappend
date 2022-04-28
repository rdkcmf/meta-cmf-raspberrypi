FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI += "file://proc-event.cfg"

SRC_URI_append_broadband = " file://remove_unused_modules.cfg"
SRC_URI_append_broadband = " file://rdkb.cfg"

SRC_URI_append_extender = " file://remove_unused_modules.cfg"
SRC_URI_append_extender = " \
                            file://rdkb.cfg \
                            file://rdkb-ext.cfg \
                            file://regdb.patch \
"

SRC_URI_remove_dunfell = " file://0001-add-support-for-http-host-headers-cookie-url-netfilt.patch "

do_configure_append_morty() {
   # meta-raspberrypi layer does not employ the YOCTO method of modifying the kernel configuration
   # through config fragments, so modify the existing .config to set options.
   sed -i "/CONFIG_SCHEDSTATS/c CONFIG_SCHEDSTATS=y" '${B}/.config'
   oe_runmake oldconfig
}

do_configure_append_pyro() {
   # meta-raspberrypi layer does not employ the YOCTO method of modifying the kernel configuration
   # through config fragments, so modify the existing .config to set options.
   sed -i "/CONFIG_SCHEDSTATS/c CONFIG_SCHEDSTATS=y" '${B}/.config'
   oe_runmake oldconfig
}

do_configure_append_rocko() {
   # meta-raspberrypi layer does not employ the YOCTO method of modifying the kernel configuration
   # through config fragments, so modify the existing .config to set options.
   sed -i "/CONFIG_SCHEDSTATS/c CONFIG_SCHEDSTATS=y" '${B}/.config'
   oe_runmake oldconfig
}

do_install_append() {
    install -d ${D}${includedir}
    install -m 0644 ${B}/include/generated/autoconf.h ${D}${includedir}/autoconf.h
}

sysroot_stage_all_append_krogoth () {
    install -d ${SYSROOT_DESTDIR}${includedir}
    install -m 0644 ${D}${includedir}/autoconf.h ${SYSROOT_DESTDIR}${includedir}/autoconf.h
}

sysroot_stage_all_append_morty () {
    install -d ${SYSROOT_DESTDIR}${includedir}
    install -m 0644 ${D}${includedir}/autoconf.h ${SYSROOT_DESTDIR}${includedir}/autoconf.h
}

sysroot_stage_all_append_dunfell () {
    install -d ${SYSROOT_DESTDIR}${includedir}
    install -m 0644 ${D}${includedir}/autoconf.h ${SYSROOT_DESTDIR}${includedir}/autoconf.h
}

sysroot_stage_all_append_pyro () {
    install -d ${SYSROOT_DESTDIR}${includedir}
    install -m 0644 ${D}${includedir}/autoconf.h ${SYSROOT_DESTDIR}${includedir}/autoconf.h
}

sysroot_stage_all_append_rocko () {
    install -d ${SYSROOT_DESTDIR}${includedir}
    install -m 0644 ${D}${includedir}/autoconf.h ${SYSROOT_DESTDIR}${includedir}/autoconf.h
}

do_deploy_append_refApp () {
    sed -i '1 s|$|vt.global_cursor_default=0|' ${DEPLOYDIR}/bcm2835-bootfiles/cmdline.txt
}

do_deploy_append_hybrid_dunfell () {
    do_deploy_dunfell_config 
}

do_deploy_append_client_dunfell () {
    do_deploy_dunfell_config 
}

do_deploy_append_ipclient_dunfell () {
    do_deploy_dunfell_config 
}

do_deploy_dunfell_config () {
    if [ "${@bb.utils.contains("DISTRO_FEATURES", "refapp", "yes", "no", d)}" = "no" ]; then
        if [ -f "${DEPLOYDIR}/bootfiles/cmdline.txt" ]; then
            sed -i 's/[[:space:]]*$//g' ${DEPLOYDIR}/bootfiles/cmdline.txt
            sed -i 's/$/ cma=256M@256M/' ${DEPLOYDIR}/bootfiles/cmdline.txt
        fi
   fi
}

PACKAGES += "kernel-autoconf"
PROVIDES += "kernel-autoconf"

FILES_kernel-autoconf = "${includedir}/autoconf.h"

KBUILD_DEFCONFIG_raspberrypi4-ext ?= "bcm2711_defconfig"
