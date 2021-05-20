FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

EXTRA_OECMAKE_remove_krogoth = "-DBUILD_OPTIMUS_STATIC_LIB=ON"
export PLATFORM = "rpi"
export PXSCENE_PLATFORM_DEFINES = " -DPXSCENE_DISABLE_PXCONTEXT_EXT -DENABLE_PX_WAYLAND_RPC"
export PXSCENE_ADDITIONAL_APP_LIBRARIES_krogoth = ""

DEPENDS += "jpeg"

SRC_URI += "file://0001-xfinity-remote-key_menu.patch \
            file://0002-keymaping-to-exit.patch \
            "

PROVIDES = "spark"
RPROVIDES_${PN} += "spark"

do_install_append_rpi () {
    if [ "${@is_spark_disabled(d)}" -eq '0' ]
    then
        sed -i 's/WPE/wayland-0/g' ${D}/home/root/pxscene.sh
    fi
}
