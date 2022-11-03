FILESEXTRAPATHS_prepend := "${THISDIR}/files:"
SRC_URI += "file://dobby.json"

EXTRA_OECMAKE_append = " -DSETTINGS_FILE=${WORKDIR}/dobby.json "
PACKAGECONFIG_append = " devicemapper"

