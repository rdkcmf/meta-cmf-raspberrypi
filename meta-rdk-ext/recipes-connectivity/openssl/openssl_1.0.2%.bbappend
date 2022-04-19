
# Note that RDK-B builds typically require hostapd and wpa-supplicant, which
# both contain hardcoded dependencies on MD4 support being enabled in openssl.
# RDK-B specific OEM layers may therefore require an additional .bbappend for
# openssl which sets:

EXTRA_OECONF_remove_class-target = "no-md4"

# Keep the complete over-ride for native builds. Temp solution, to be removed
# once meta-rdk-ext .bbappend for openssl is updated to append RDK specific
# config options to the target build only.
# Fix for building python-m2crypto-native.

EXTRA_OECONF_class-native = "-no-ssl3"

DEPENDS += "libtool"

FILESEXTRAPATHS_prepend := "${THISDIR}/files:"
SRC_URI_append_morty = " file://cobalt.service"

inherit systemd

SYSLOG-NG_SERVICE_cobalt = "cobalt.service"
SYSTEMD_AUTO_ENABLE_${PN} = "enable"
SYSTEMD_SERVICE_${PN} = "cobalt.service"

do_install_append_morty() {
    install -d ${D}${systemd_unitdir}/system
    install -m 0644 ${WORKDIR}/cobalt.service ${D}${systemd_unitdir}/system/

    install -Dm 0755 ${WORKDIR}/openssl-c_rehash.sh ${D}/lib/rdk/c_rehash.sh
    sed -i 's\DIR=/etc/openssl\DIR=/etc/ssl\g' ${D}/lib/rdk/c_rehash.sh
}

FILES_${PN} += "${base_libdir}/rdk/*"
FILES_${PN} += "${systemd_unitdir}/system/cobalt.service"
