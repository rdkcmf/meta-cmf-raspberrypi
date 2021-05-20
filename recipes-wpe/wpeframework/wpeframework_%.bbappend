DEPENDS += " westeros"

inherit coverity

# add userland depends only if no vc4graphics enabled also remove userland as meta-wpe won't allow to override
RDEPENDS_${PN}_remove_rpi = "${@bb.utils.contains('MACHINE_FEATURES', 'vc4graphics', 'userland', '', d)}" 
RDEPENDS_${PN}_append_rpi = " ${@bb.utils.contains('MACHINE_FEATURES', 'vc4graphics', '', 'userland', d)}"

do_install_append () {
  if ${@bb.utils.contains('MACHINE_FEATURES', 'vc4graphics', 'true', 'false', d)}; then
    sed -i '/Environment="LD_PRELOAD=/ c\Environment="LD_PRELOAD=/usr/lib/libwesteros_gl.so.0"' ${D}${systemd_unitdir}/system/${PN}.service
  fi
}
