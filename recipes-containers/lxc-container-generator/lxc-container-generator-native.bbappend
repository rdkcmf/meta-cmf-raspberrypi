FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI_lxcsecure += " \
        file://defaultSeccompProfile \
        file://xml/dobby_conf_htmlapp.xml \
        file://xml/dobby_conf_lightningapp.xml \
        file://xml/dobby_conf_cobalt.xml \
"

do_install_append_lxcsecure() {
    install_lxc_config secure dobby_conf_htmlapp.xml
    install_lxc_config secure dobby_conf_lightningapp.xml
    install_lxc_config secure dobby_conf_cobalt.xml
    install -m 0755 ${WORKDIR}/defaultSeccompProfile ${D}${datadir}/${BPN}/src/lib/dobby
}
