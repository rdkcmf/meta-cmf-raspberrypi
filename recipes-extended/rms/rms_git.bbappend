FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI += "file://startRMS.sh \
     file://rms-launcher.service \
     file://rms.conf \
     file://rms_rtsp.patch;apply=no \
"

S = "${WORKDIR}/git"

do_configure_prepend() {
cp ${WORKDIR}/startRMS.sh ${S}/
cp ${WORKDIR}/rms-launcher.service ${S}/
cp ${WORKDIR}/rms.conf ${S}/
}

do_install_append() {
install -Dm755 ${S}/startRMS.sh ${D}${base_libdir}/rdk/startRMS.sh
install -d ${D}${systemd_unitdir}/system
install -m 0644 ${S}/rms-launcher.service ${D}${systemd_unitdir}/system/

install -Dm755 ${S}/rms.conf ${D}${prefix}/local/rms/bin/
}

SYSTEMD_SERVICE_${PN}_append = "rms-launcher.service"

FILES_${PN}_append = " \
     ${systemd_unitdir}/system/rms-launcher.service \
     ${base_libdir}/rdk/startRMS.sh \
"

inherit systemd

do_rdkcms_patches() {
    cd ${S}
    if [ ! -e patch_applied ]; then
        patch -p1 < ${WORKDIR}/rms_rtsp.patch
        touch patch_applied
    fi
}

addtask rdkcms_patches after do_unpack before do_compile
