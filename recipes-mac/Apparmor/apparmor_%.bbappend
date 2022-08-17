FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"
SRC_URI_append = " \
         file://apparmor_parse.sh \
         file://profiles/ \
         file://default \
         "
#PACKAGE_BEFORE_PN += "${PN}-optimized"

do_install_append () {
    # Our startup/init script
    install -d ${D}${sysconfdir}/apparmor/caps
    install -m 0555 ${WORKDIR}/apparmor_parse.sh ${D}${sysconfdir}/apparmor/
    if [ ! -d ${D}/etc/apparmor.d/ ]; then
           mkdir ${D}/etc/apparmor.d/
    fi
    #installing apparmor profiles
    install -m 0555 ${WORKDIR}/profiles/* ${D}${sysconfdir}/apparmor.d/
    install -m 0555 ${WORKDIR}/default ${D}${sysconfdir}/apparmor/caps/
}
FILES_${PN}-optimized = "${sysconfdir}/apparmor/parser.conf \
                         ${sysconfdir}/apparmor/subdomain.conf \
                         ${sysconfdir}/init.d/apparmor \
                         ${base_libdir}/apparmor/functions \
                         ${base_libdir}/apparmor/rc.apparmor.functions \
                         ${bindir}/aa-enabled \
                         ${bindir}/aa-exec"

