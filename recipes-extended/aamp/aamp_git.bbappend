EXTRA_OECMAKE_remove_rpi = " -DCMAKE_USE_CLEARKEY=1"
EXTRA_OECMAKE_remove_rpi = " -DCMAKE_USE_WIDEVINE=1"
EXTRA_OECMAKE_remove_rpi = " -DCMAKE_USE_PLAYREADY=1"

DEPENDS += "wpe-webkit"

ADDAAMPPLAYER="${@bb.utils.contains("DISTRO_FEATURES", "build_rne", "1", "0", d)}"
do_install_append() {
if [ "${ADDAAMPPLAYER}" = "1" ]; then
    install -d ${D}/home/root/aamprefplayer
    cp -r ${S}/test/ReferencePlayer/* ${D}/home/root/aamprefplayer/
fi

if [ ! -f ${D}/opt/aamp.cfg ]; then
    install -d ${D}/opt
fi
echo "useWesterosSink=1" >> ${D}/opt/aamp.cfg
}

FILES_${PN} += "${@bb.utils.contains("DISTRO_FEATURES", "build_rne", "/home/root/", "", d)}"
FILES_${PN} += "/opt/aamp.cfg"
