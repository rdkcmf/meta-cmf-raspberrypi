FILESEXTRAPATHS_prepend := "${THISDIR}/files:"
SRC_URI += " \
    file://0005-souphttpsrc-cookie-jar-and-context-query-support.patch \
"
SRC_URI +="${@bb.utils.contains('DISTRO_FEATURES', 'bluetooth', 'file://0006-sbcparse-assert.patch', '', d)}"

SRC_URI_remove = "file://0001-qtdemux-distinguish-TFDT-with-value-0-from-no-TFDT-a.patch "

PACKAGECONFIG_append = "matroska"
PACKAGECONFIG[matroska] = "--disable-matroska"

PACKAGECONFIG_remove_camera = "matroska"
