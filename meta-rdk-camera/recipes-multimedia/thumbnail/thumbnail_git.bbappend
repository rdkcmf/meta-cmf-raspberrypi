
FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI += "file://thumbnail.patch;apply=no \
	   "

S = "${WORKDIR}/git"

do_thumbnail_patches() {
    cd ${S}
    if [ ! -e patch_applied ]; then
        patch -p1 < ${WORKDIR}/thumbnail.patch
        touch patch_applied
    fi
}

addtask thumbnail_patches after do_unpack before do_compile
