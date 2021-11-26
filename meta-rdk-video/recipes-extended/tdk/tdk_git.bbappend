FILESEXTRAPATHS_prepend := "${THISDIR}/${BPN}:"

SRC_URI_append = " \
    ${CMF_GIT_ROOT}/rdk/devices/raspberrypi/tdk;protocol=${CMF_GIT_PROTOCOL};branch=${CMF_GIT_BRANCH};destsuffix=git/platform/raspberrypi;name=tdkraspberrypi \
"
SRCREV_tdkraspberrypi = "${AUTOREV}"

do_fetch[vardeps] += "SRCREV_tdkraspberrypi"
SRCREV_FORMAT = "tdk_tdkraspberrypi"
export MAX_NUM_TUNERS = "1"

CXXFLAGS+="-DREFPL_RDKV"

EXTRA_OEMAKE_remove = "--enable-client"

DEPENDS += "gst-plugins-rdk"
DEPENDS_remove = "bluetooth-mgr"

inherit pkgconfig

do_configure_prepend_hybrid () {
    sed -i -e 's/SUBDIR_CLIENT="TR069_stub";;/;;/' ${S}/configure.ac
    sed -i -e 's/SUBDIR_CLIENT="TR069_stub"/#SUBDIR_CLIENT="TR069_stub"/' ${S}/configure.ac
}

do_configure_prepend () {
    sed -i -e 's/PKG_CHECK_MODULES(\[GST\_CHECK\]/#PKG_CHECK_MODULES(\[GST\_CHECK\]/' ${S}/configure.ac
}

do_install_append () {
    install -D -p -m 755 ${S}/platform/raspberrypi/agent/scripts/* ${D}${TDK_TARGETDIR}/
}
do_install_append_dunfell() {
    sed -i "/export XDG_RUNTIME_DIR=/ c\export XDG_RUNTIME_DIR=/tmp" ${D}${TDK_TARGETDIR}/StartTDK.sh
    sed -i "/export LD_PRELOAD=/ c\export LD_PRELOAD=/usr/lib/libwesteros_gl.so.0" ${D}${TDK_TARGETDIR}/StartTDK.sh

    #Added to remove extra westerossink logs from Agentconsole log file. Otherwise log upload is taking more time.
    #Checking with platform team for permanent solution
    sed -i -e "22a sed -i \'/westerossink-ioctl/d\' \$1" ${D}${TDK_TARGETDIR}/uploadLogs.sh
}
