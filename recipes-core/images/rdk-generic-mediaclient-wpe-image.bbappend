require recipes-core/images/rdk-generic-mediaclient-wpe-image.bb
require recipes-core/images/add-non-root-user-group.inc

IMAGE_INSTALL_append = " \
   hdhomerun \
   rdkapps \
   parodus \
   tr69hostif \
   tr69agent \
"

IMAGE_INSTALL_remove = " \
    westeros-init \
    wpe-webkit-init \
"
# Space is required for firmware upgrade
IMAGE_ROOTFS_EXTRA_SPACE = "204800"

ROOTFS_POSTPROCESS_COMMAND += "append_version; "

append_version() {
        echo "JENKINS_JOB=0" >> ${IMAGE_ROOTFS}/version.txt
        echo "JENKINS_BUILD_NUMBER=0" >> ${IMAGE_ROOTFS}/version.txt
}

#bluealsa
IMAGE_INSTALL_append = " ${@bb.utils.contains('DISTRO_FEATURES', 'bluealsa', ' bluealsa alsa-utils alsa-lib', '', d)}"
