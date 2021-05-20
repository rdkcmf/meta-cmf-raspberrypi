require recipes-graphics/westeros/westeros.inc
SRCREV = "${AUTOREV}"

SUMMARY = "This receipe compiles the westeros compositor rpi display module component"

LICENSE_LOCATION = "${S}/../../../LICENSE"

S = "${WORKDIR}/git/rpi/modules/resolution"

DEPENDS = "westeros wayland glib-2.0"

inherit autotools pkgconfig

COMPATIBLE_MACHINE_rpi = "${@bb.utils.contains('MACHINE_FEATURES', 'vc4graphics', 'null', '(.*)', d)}"
