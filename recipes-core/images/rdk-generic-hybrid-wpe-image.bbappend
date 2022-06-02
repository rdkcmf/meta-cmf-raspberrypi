require recipes-core/images/rdk-generic-hybrid-wpe-image.bb
require recipes-core/images/add-non-root-user-group.inc

IMAGE_INSTALL_append = " \
   gstqamtunersrc \
   hdhomerun \
   rdkapps \
   parodus \
   tr69hostif \
   tr69agent \
   tzdata \
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

IMAGE_PREPROCESS_COMMAND_append_morty = "fixes_tty1_removal;"
fixes_tty1_removal() {
    if [ -f ${IMAGE_ROOTFS}/etc/systemd/system/getty.target.wants/getty@tty1.service ]; then
            rm -f "${IMAGE_ROOTFS}/etc/systemd/system/getty.target.wants/getty@tty1.service"
    fi
}
