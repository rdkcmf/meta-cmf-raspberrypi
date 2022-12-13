FILESEXTRAPATHS_prepend:="${THISDIR}/files:"

do_install_append () {
                install -d ${D}/fss/gw/usr/bin
                ln -sf ${bindir}/igmpproxy ${D}/fss/gw/usr/bin/igmpproxy
}

FILES_${PN} += " \
               /fss/gw/usr/bin/igmpproxy \
               "
