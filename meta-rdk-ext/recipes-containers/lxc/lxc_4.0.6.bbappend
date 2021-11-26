FILESEXTRAPATHS_prepend := "${THISDIR}/files:"
SRC_URI_append = "${@bb.utils.contains('DISTRO_FEATURES', 'lxc-secure-containers', ' file://lxc.conf ', '', d)}"

do_install_append() {
    if [ "${@bb.utils.contains("DISTRO_FEATURES", "lxc-secure-containers", "yes", "no", d)}" = "yes" ]; then
        install -d ${D}${sysconfdir}/tmpfiles.d
        install -m 0644 ${WORKDIR}/lxc.conf ${D}${sysconfdir}/tmpfiles.d/
    fi
}
