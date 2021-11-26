FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI_append = " \
        file://001-enable-asyn-handlingacross-pluginsinrpi.patch \
                 "
