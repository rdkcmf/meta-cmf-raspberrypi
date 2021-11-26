PACKAGECONFIG_remove = "lostfound"
EXTRA_OECONF_append = " --enable-nlmonitor --enable-iarm --enable-route-support"
EXTRA_OEMAKE="IARM_LFLAGS=-lIARMBus -ldbus-1"
