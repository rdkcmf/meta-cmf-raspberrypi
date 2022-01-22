EXTRA_OECONF += " --enable-pi-build "

do_install_append() {
    if ${@bb.utils.contains('DISTRO_FEATURES', 'systemd', 'true', 'false', d)}; then
        sed -i 's/bluetooth.service/bluetooth.service\ bthelper@hci0.service\ /g' ${D}${systemd_system_unitdir}/btmgr.service
    fi
}
