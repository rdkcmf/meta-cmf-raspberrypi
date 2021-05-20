FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

do_install_append(){
sed -i 's/killall westeros/killall/g' ${D}${bindir}/rdkbrowser2.sh
sed -i '/westeros.log/s/^/#/g' ${D}${bindir}/rdkbrowser2.sh
sed -i '/tmp/d' ${D}${bindir}/rdkbrowser2.sh
sed -i '/main0/d' ${D}${bindir}/rdkbrowser2.sh
sed -i '/LD_PRELOAD/d' ${D}${bindir}/rdkbrowser2.sh
}

SRC_URI_append = "${@bb.utils.contains('DISTRO_FEATURES', 'lxc-secure-containers', ' file://rdkbrowser2.service ', '', d)}"
SRC_URI_append = "${@bb.utils.contains('DISTRO_FEATURES', 'lxc-secure-containers', ' file://rdkbrowser2.conf ', '', d)}"

do_install_append() {
    if [ "${@bb.utils.contains("DISTRO_FEATURES", "lxc-secure-containers", "yes", "no", d)}" = "yes" ]; then
        install -d ${D}${systemd_unitdir}/system
        install -m 0644 ${WORKDIR}/rdkbrowser2.service ${D}${systemd_unitdir}/system

        install -d ${D}${sysconfdir}/tmpfiles.d
        install -m 0644 ${WORKDIR}/rdkbrowser2.conf ${D}${sysconfdir}/tmpfiles.d/
    fi
}

FILES_${PN}_append = "${@bb.utils.contains('DISTRO_FEATURES', 'lxc-secure-containers', ' ${sysconfdir}/tmpfiles.d/rdkbrowser2.conf ', '', d)}"
FILES_${PN}_append = "${@bb.utils.contains('DISTRO_FEATURES', 'lxc-secure-containers', ' ${systemd_unitdir}/system/rdkbrowser2.service ', '', d)}"


SYSTEMD_SERVICE_${PN} = "rdkbrowser2.service"

