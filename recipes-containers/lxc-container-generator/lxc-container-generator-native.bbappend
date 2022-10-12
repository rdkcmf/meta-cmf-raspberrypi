FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI += " \
        file://xml/dobby_conf_htmlapp.xml \
        file://xml/dobby_conf_lightningapp.xml \
"

do_install_append() {
    install_lxc_config secure dobby_conf_htmlapp.xml
    install_lxc_config secure dobby_conf_lightningapp.xml
}
