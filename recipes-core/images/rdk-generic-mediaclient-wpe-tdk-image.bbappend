require recipes-core/images/rdk-generic-mediaclient-wpe-image.bb
require recipes-core/images/add-non-root-user-group.inc

IMAGE_FEATURES += "tdk"

IMAGE_INSTALL_append = " \
   packagegroup-tdk \
   hdhomerun \
   rdkapps \
   parodus \
   tr69hostif \
   tr69agent \
   alsa-utils \
   alsa-lib   \
"

IMAGE_INSTALL_append_dunfell = " \
   bluealsa  \
"

IMAGE_INSTALL_remove = " \
    westeros-init \
    wpe-webkit-init \
"

PACKAGE_EXCLUDE_pn-rdk-generic-mediaclient-westeros-wpe-tdk-image = "${@bb.utils.contains('DISTRO_FEATURES','ENABLE_IPK','packagegroup-tdk','',d)}"

ROOTFS_POSTPROCESS_COMMAND += "append_version; "

append_version() {
        echo "JENKINS_JOB=0" >> ${IMAGE_ROOTFS}/version.txt
        echo "JENKINS_BUILD_NUMBER=0" >> ${IMAGE_ROOTFS}/version.txt
}
