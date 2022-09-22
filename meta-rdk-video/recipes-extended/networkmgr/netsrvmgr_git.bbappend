FILESEXTRAPATHS_prepend := "${THISDIR}/files:"
SRC_URI_append_ipclient += "file://ipclient-wifi-connect.patch;apply=no"
# wifi connection
do_wifi_connect_patch() {
    cd ${S}
    if [ ! -e patch_applied ]; then
        if [ -f ${WORKDIR}/ipclient-wifi-connect.patch ]; then
            bbnote "ipclient-wifi-connect.patch"
            patch -p1 < ${WORKDIR}/ipclient-wifi-connect.patch
            touch patch_applied
        fi
    fi
}
addtask wifi_connect_patch after do_unpack before do_configure

PACKAGECONFIG_remove = "lostfound"
EXTRA_OECONF_append = " --enable-nlmonitor --enable-iarm --enable-route-support"
EXTRA_OEMAKE="IARM_LFLAGS=-lIARMBus -ldbus-1"
