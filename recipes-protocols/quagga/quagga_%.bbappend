PACKAGE_BEFORE_PN=""

INITSCRIPT_PACKAGES = ""
INITSCRIPT_NAME_${PN} = ""
INITSCRIPT_PARAMS_${PN} = ""

SYSTEMD_PACKAGES = "${PN}"
SYSTEMD_SERVICE_${PN} = ""

PACKAGE_BEFORE_PN = ""
RDEPENDS_${PN} = ""

do_install_append() {
    # do not install quagga services
    rm -rf ${D}${sysconfdir}/quagga
    rm -rf ${D}/lib
}
