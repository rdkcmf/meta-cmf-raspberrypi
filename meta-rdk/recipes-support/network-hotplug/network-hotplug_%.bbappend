do_install_append_rpi() {
    # removing dependency of network@.service on MOCA_INTERACE as raspberry pi does not have MOCA.
    sed -i -e '/device.properties/s/^/#/' ${D}/lib/systemd/system/network@.service
    sed -i -e '/MOCA_INTERFACE/s/^/#/' ${D}/lib/systemd/system/network@.service
    # make sure udhcpc is run when multiuser target boots
    install -d ${D}${sysconfdir}/systemd/system/multi-user.target.wants
    ln -sf ${systemd_unitdir}/system/udhcpc@.service ${D}${sysconfdir}/systemd/system/multi-user.target.wants/udhcpc@eth0.service
    ln -sf ${systemd_unitdir}/system/udhcpc@.service ${D}${sysconfdir}/systemd/system/multi-user.target.wants/udhcpc@wlan0.service
}

FILES_${PN} += "/etc/systemd \
                /etc/systemd/system \
                /etc/systemd/system/multi-user.target.wants \
                /etc/systemd/system/multi-user.target.wants/udhcpc@eth0.service \
                /etc/systemd/system/multi-user.target.wants/udhcpc@wlan0.service"
