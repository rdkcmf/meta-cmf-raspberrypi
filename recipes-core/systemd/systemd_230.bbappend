PACKAGECONFIG_append = " resolved"
FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI_append = " \
        file://01-Avoid-warnings-aboutmissing-componentsof-reboot-paramsfile.patch \
                 "
