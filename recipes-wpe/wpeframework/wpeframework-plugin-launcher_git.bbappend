DEPENDS += " wpeframework"
RDEPENDS_${PN} += " wpeframework"

do_install_append() {
   rm -rf ${D}/etc/*
}
