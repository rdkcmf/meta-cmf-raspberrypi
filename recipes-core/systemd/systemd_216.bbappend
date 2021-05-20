FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI_append = " \
    file://kill_init.sh \
"
do_install_append_rpi() {
    if [ -e ${D}/lib/systemd/system/systemd-timesyncd.service ]; then
        sed -i -e 's/^Restart=always/Restart=no/' ${D}/lib/systemd/system/systemd-timesyncd.service
        sed -i -e 's/^WatchdogSec=1min/WatchdogSec=11\nTimeoutSec=10/' ${D}/lib/systemd/system/systemd-timesyncd.service
    fi
    if [ -e ${D}/lib/systemd/system/systemd-logind.service ]; then
        sed -i -e 's/^ExecStart=\/lib\/systemd\/systemd-logind/ExecStartPre=\/lib\/rdk\/kill_init.sh\nExecStart=\/lib\/systemd\/systemd-logind/' ${D}/lib/systemd/system/systemd-logind.service
    fi
    install -d ${D}/lib/rdk/
    install -D -m 777 ${WORKDIR}/kill_init.sh ${D}/lib/rdk/kill_init.sh
}

FILES_${PN}_append = " \
    /lib/rdk/kill_init.sh \
"
