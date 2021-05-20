EXTRA_OECONF_remove_rpi = " --disable-resizer"

FILES_${PN}_append = " ${base_sbindir}/resize2fs*"
PACKAGECONFIG_append = " e2fsprogs e2fsprogs-resize2fs"

