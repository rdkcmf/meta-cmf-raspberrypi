require add-container-user-group.inc
IMAGE_INSTALL_append = " \
   tzdata \
"

IMAGE_PREPROCESS_COMMAND_append_morty = "fixes_tty1_removal;"
fixes_tty1_removal() {
    if [ -f ${IMAGE_ROOTFS}/etc/systemd/system/getty.target.wants/getty@tty1.service ]; then
            rm -f "${IMAGE_ROOTFS}/etc/systemd/system/getty.target.wants/getty@tty1.service"
    fi
}

