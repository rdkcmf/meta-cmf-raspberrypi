FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI_lxcsecure += " \
        file://cobaltSeccompProfile \
        file://defaultSeccompProfile \
        file://xml/dobby_conf_htmlapp.xml \
        file://xml/dobby_conf_lightningapp.xml \
        ${@bb.utils.contains('DISTRO_FEATURES_NATIVE', 'harden_dobby', 'file://xml/dobby_conf_hardened_cobalt.xml', 'file://xml/dobby_conf_cobalt.xml', d)} \
"

do_install_append_lxcsecure() {

   if [ "${@bb.utils.contains('DISTRO_FEATURES_NATIVE', 'harden_dobby', 'true', 'false', d)}" = "true" ]; then
      install -m 644 ${WORKDIR}/xml/dobby_conf_hardened_cobalt.xml ${D}${datadir}/${BPN}/secure/dobby_conf_cobalt.xml
   else 
      install_lxc_config secure dobby_conf_htmlapp.xml
      install_lxc_config secure dobby_conf_lightningapp.xml
      install_lxc_config secure dobby_conf_cobalt.xml
   fi
      install -m 0755 ${WORKDIR}/cobaltSeccompProfile ${D}${datadir}/${BPN}/src/lib/dobby
      install -m 0755 ${WORKDIR}/defaultSeccompProfile ${D}${datadir}/${BPN}/src/lib/dobby
}
