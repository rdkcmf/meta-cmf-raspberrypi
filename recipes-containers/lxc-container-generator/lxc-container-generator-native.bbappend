FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI_lxcsecure += " \
        file://xml/dobby_conf_htmlapp.xml \
        file://xml/dobby_conf_lightningapp.xml \
"

do_install_append_lxcsecure() {
    install_lxc_config secure dobby_conf_htmlapp.xml
    install_lxc_config secure dobby_conf_lightningapp.xml
}
