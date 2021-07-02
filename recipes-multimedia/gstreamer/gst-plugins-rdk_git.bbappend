CFLAGS += "-UENABLE_READ_DELAY"
CFLAGS += " -DREF_PLATFORM"

RDEPENDS_${PN}_remove_ipclient = "${VIRTUAL-RUNTIME_dtcpmgr}"

PACKAGECONFIG_remove = "${@bb.utils.contains('DISTRO_FEATURES', 'ipclient', 'tcpdec dtcpenc', '', d)}"

DEPENDS_remove = "${@bb.utils.contains('DISTRO_FEATURES', 'ipclient', 'rmfgeneric', '', d)} "
