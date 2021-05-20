FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

DEPENDS_append = " ${@bb.utils.contains('DISTRO_FEATURES', 'telemetry2_0', 'telemetry', '', d)}"
LDFLAGS_append = " ${@bb.utils.contains('DISTRO_FEATURES', 'telemetry2_0', ' -ltelemetry_msgsender ', '', d)}"

SYSTEMD_AUTO_ENABLE_${PN} = "enable"
SRC_URI_append = " 		 \
    file://hostapd0.conf \
    file://hostapd1.conf \
    file://hostapd4.conf \
    file://hostapd5.conf \
    file://sec_file.txt  \
    file://bw_file.txt  \
    file://hostapd.service \
    file://hostapd_start.sh \
    file://defconfig \
    file://backup_checkup_hostapd.sh \
"

do_install_append() {
    install -d ${D}${sysconfdir}
    install -d ${D}/usr/ccsp/wifi/
    install -d ${D}${prefix}/hostapd
    install -d ${D}${sysconfdir}/hostapd
    install -m 755 ${WORKDIR}/hostapd0.conf ${D}/usr/ccsp/wifi/
    install -m 755 ${WORKDIR}/hostapd1.conf ${D}/usr/ccsp/wifi/
    install -m 755 ${WORKDIR}/hostapd4.conf ${D}/usr/ccsp/wifi/
    install -m 755 ${WORKDIR}/hostapd5.conf ${D}/usr/ccsp/wifi/
    install -m 755 ${WORKDIR}/sec_file.txt ${D}${sysconfdir}
    install -m 755 ${WORKDIR}/bw_file.txt ${D}${sysconfdir}
    install -m 644 ${WORKDIR}/hostapd.service ${D}${systemd_unitdir}/system/
    install -m 755 ${WORKDIR}/hostapd_start.sh ${D}${prefix}/hostapd/
    install -m 755 ${WORKDIR}/backup_checkup_hostapd.sh  ${D}${prefix}/hostapd/
    touch ${D}${sysconfdir}/hostapd/hostapd0.psk
    touch ${D}${sysconfdir}/hostapd/hostapd1.psk
}

FILES_${PN} += " \
	${prefix}/hostapd/* \
	${sysconfdir}/hostapd/* \
	${prefix}/ccsp/wifi/hostapd0.conf \
	${prefix}/ccsp/wifi/hostapd1.conf \
	${prefix}/ccsp/wifi/hostapd4.conf \
	${prefix}/ccsp/wifi/hostapd5.conf \
"
