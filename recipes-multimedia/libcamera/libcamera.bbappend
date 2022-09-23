FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

LIC_FILES_CHKSUM_remove = "\
    file://licenses/gnu-gpl-2.0.txt;md5=b234ee4d69f5fce4486a80fdaf4a4263 \
    file://licenses/gnu-lgpl-2.1.txt;md5=4b54a1fd55a448865a0b32d41598759d \
"

LIC_FILES_CHKSUM = "\
    file://LICENSES/GPL-2.0-or-later.txt;md5=fed54355545ffd980b814dab4a3b312c \
    file://LICENSES/LGPL-2.1-or-later.txt;md5=2a4f4fd2128ea2f65047ee63fbca9f68 \
"

SRC_URI += "file://libcamera_meson_685da13d02.patch \
"

SRCREV_remove = "a8be6e94e79f602d543a15afd44ef60e378b138f"
SRCREV = "685da13d02c01ed0a2bb7080f95b7ac56e80f221"

PV_remove = "202002+git${SRCPV}"
PV = "202209+git${SRCPV}"

DEPENDS += "python3-jinja2-native python3-ply-native libevent gnutls boost chrpath-native libyaml"

PACKAGES =+ "${PN}-gst"

PACKAGECONFIG ??= "gst"
PACKAGECONFIG[gst] = "-Dgstreamer=enabled,-Dgstreamer=disabled,gstreamer1.0 gstreamer1.0-plugins-base"

do_install_append() {
    chrpath -d ${D}${libdir}/libcamera.so
}

addtask do_recalculate_ipa_signatures_package after do_package before do_packagedata
do_recalculate_ipa_signatures_package() {
    local modules
    for module in $(find ${PKGD}/usr/lib/libcamera -name "*.so.sign"); do
        module="${module%.sign}"
        if [ -f "${module}" ] ; then
            modules="${modules} ${module}"
        fi
    done

    ${S}/src/ipa/ipa-sign-install.sh ${B}/src/ipa-priv-key.pem "${modules}"

}

FILES_${PN}-gst = "${libdir}/gstreamer-1.0/libgstlibcamera.so"

INSANE_SKIP_${PN} = "dev-so"
