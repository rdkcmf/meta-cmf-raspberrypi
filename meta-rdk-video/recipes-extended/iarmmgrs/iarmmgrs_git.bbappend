FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI_append = " \
                file://0001-xfinity-and-exit-keymap.patch;apply=no \
                "
# we need to patch to code for RPi
do_rpi_patches() {
    cd ${S}
    if [ ! -e patch_applied ]; then
        patch -p1 < ${WORKDIR}/0001-xfinity-and-exit-keymap.patch
        touch patch_applied
    fi
}
addtask rpi_patches after do_unpack before do_compile

# enable deep sleep
INCLUDE_DIRS += "-I${S}/deepsleepmgr/include \
                 -I${S}/hal/include "

CFLAGS += "-DENABLE_THERMAL_PROTECTION"
CFLAGS +="-DENABLE_DEEP_SLEEP -DRDK_MFRLIB_NAME='${MFR_LIB}' -DUSE_MFR_FOR_SERIAL"
CFLAGS += "${@bb.utils.contains('DISTRO_FEATURES', 'systemd','-DENABLE_SD_NOTIFY', '',d)}"
CFLAGS_remove = "-DENABLE_MFR_WIFI"
LDFLAGS += "-liarmmgrs-deepsleep-hal ${MFR_LIB_NAME} -ldl"
LDFLAGS += "${@bb.utils.contains('DISTRO_FEATURES', 'systemd','-lsystemd', '',d)}"

do_compile_append(){
    oe_runmake -B -C ${S}/deepsleepmgr/
    export RDK_PLATFORM_SOC=rpi
    oe_runmake -B -C ${S}/mfr/
}
do_install_append() {
    install -m 0644 ${S}/conf/deepsleepmgr.service ${D}${systemd_unitdir}/system
    install -m 0755 ${S}/deepsleepmgr/deepSleepMgrMain ${D}${bindir}

    install -m 0755 ${S}/mfr/*Main ${D}${bindir}
    install -m 0644 ${S}/conf/mfrmgr.service ${D}${systemd_unitdir}/system
}

FILES_${PN} += "${bindir}/deepSleepMgrMain \
                ${bindir}/mfrMgrMain"

SYSTEMD_SERVICE_${PN} += "deepsleepmgr.service mfrmgr.service"

# for feature lxc-secure-containers
CFLAGS_append = "${@bb.utils.contains('DISTRO_FEATURES', 'lxc-secure-containers', ' -DPID_FILE_PATH="/var/run/platformcontrol" ', '', d)}"
SRC_URI_append = "${@bb.utils.contains('DISTRO_FEATURES', 'lxc-secure-containers', ' file://dsmgr.service ', '', d)}"
SRC_URI_append = "${@bb.utils.contains('DISTRO_FEATURES', 'lxc-secure-containers', ' file://irmgr.service ', '', d)}"
SRC_URI_append = "${@bb.utils.contains('DISTRO_FEATURES', 'lxc-secure-containers', ' file://sysmgr.service ', '', d)}"
SRC_URI_append = "${@bb.utils.contains('DISTRO_FEATURES', 'lxc-secure-containers', ' file://dsmgr.conf ', '', d)}"
SRC_URI_append = "${@bb.utils.contains('DISTRO_FEATURES', 'lxc-secure-containers', ' file://irmgr.conf ', '', d)}"

do_install_append() {
    if [ "${@bb.utils.contains("DISTRO_FEATURES", "lxc-secure-containers", "yes", "no", d)}" = "yes" ]; then
        install -d ${D}${systemd_unitdir}/system
        install -m 0644 ${WORKDIR}/dsmgr.service ${D}${systemd_unitdir}/system
        install -m 0644 ${WORKDIR}/irmgr.service ${D}${systemd_unitdir}/system
        install -m 0644 ${WORKDIR}/sysmgr.service ${D}${systemd_unitdir}/system

        install -d ${D}${sysconfdir}/tmpfiles.d
        install -m 0644 ${WORKDIR}/irmgr.conf ${D}${sysconfdir}/tmpfiles.d/
        install -m 0644 ${WORKDIR}/dsmgr.conf ${D}${sysconfdir}/tmpfiles.d/
    fi
}

FILES_${PN}_append = "${@bb.utils.contains('DISTRO_FEATURES', 'lxc-secure-containers', ' ${sysconfdir}/tmpfiles.d/irmgr.conf ', '', d)}"
FILES_${PN}_append = "${@bb.utils.contains('DISTRO_FEATURES', 'lxc-secure-containers', ' ${sysconfdir}/tmpfiles.d/dsmgr.conf ', '', d)}"
