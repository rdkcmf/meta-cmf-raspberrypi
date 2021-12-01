require recipes-core/images/rdk-generic-hybrid-wpe-image.bb

inherit extrausers
inherit file-owners-and-permissions
inherit image_container_generator

require add-users-groups-file-owners-and-permissions.inc
require recipes-core/images/add-non-root-user-group.inc

IMAGE_INSTALL += " \
        packagegroup-lxc-secure-containers \
        strace \
	gstqamtunersrc \
	rdkapps \
"

IMAGE_INSTALL_remove = " \
    westeros-init \
    wpe-webkit-init \
"

ROOTFS_POSTPROCESS_COMMAND += "disable_systemd_services; "

disable_systemd_services() {
        if [ -d ${IMAGE_ROOTFS}${sysconfdir}/systemd/system/multi-user.target.wants/ ]; then
                rm -f ${IMAGE_ROOTFS}${sysconfdir}/systemd/system/multi-user.target.wants/wizardkit.service;

        fi
}

