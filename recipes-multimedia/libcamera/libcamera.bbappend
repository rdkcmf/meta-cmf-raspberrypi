FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

LIC_FILES_CHKSUM_remove = "\
    file://licenses/gnu-gpl-2.0.txt;md5=b234ee4d69f5fce4486a80fdaf4a4263 \
    file://licenses/gnu-lgpl-2.1.txt;md5=4b54a1fd55a448865a0b32d41598759d \
"

LIC_FILES_CHKSUM = "\
    file://LICENSES/GPL-2.0-or-later.txt;md5=fed54355545ffd980b814dab4a3b312c \
    file://LICENSES/LGPL-2.1-or-later.txt;md5=2a4f4fd2128ea2f65047ee63fbca9f68 \
"

SRC_URI += "file://libcamera.patch;apply=no \
"

SRCREV_remove = "a8be6e94e79f602d543a15afd44ef60e378b138f"
SRCREV = "5988661c9047fc04840603068a94466719319725"

PV_remove = "202002+git${SRCPV}"
PV = "202008+git${SRCPV}"

TARGET_CFLAGS_append_rpi += "-DENABLE_LIBCAMERA_RPI_CONFIG"

DEPENDS += "python3-jinja2-native python3-ply-native libevent gnutls boost chrpath-native"

PACKAGES =+ "${PN}-gst"

#PACKAGECONFIG ??= "gst, -DENABLE_LIBCAMERA_RPI_CONFIG"
PACKAGECONFIG ??= "gst"
PACKAGECONFIG[gst] = "-Dgstreamer=enabled,-Dgstreamer=disabled,gstreamer1.0 gstreamer1.0-plugins-base"

do_install_append() {
    chrpath -d ${D}${libdir}/libcamera.so
}
do_libcamera_patches() {
    cd ${S}
    if [ ! -e patch_applied ]; then
        patch -p1 < ${WORKDIR}/libcamera.patch
        touch patch_applied
    fi
}
addtask libcamera_patches after do_unpack before do_compile


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
