SUMMARY = "A console-only image for the RDK-B yocto build"

inherit rdk-image

IMAGE_FEATURES += "broadband"

IMAGE_ROOTFS_SIZE = "8192"

IMAGE_INSTALL_append = " \
    packagegroup-rdk-oss-broadband \
    packagegroup-rdk-ccsp-broadband \
    rdk-logger \
    "

IMAGE_INSTALL_append_container = " \
   gzip \
   perl \
   libcap \
   bridge-utils \
   eglibc \
   lxc \
   file \
   strace \
   "

inherit extrausers
inherit file-owners-and-permissions
inherit image_container_generator

require add-users-groups-file-owners-and-permissions-broadband.inc
require recipes-core/images/add-non-root-user-group.inc

IMAGE_INSTALL += " \
        packagegroup-lxc-secure-containers \
"

python __anonymous () {
    if "broadband" not in d.getVar('MACHINEOVERRIDES', True):
        raise bb.parse.SkipPackage("Image is meant for broadband class of devices")
}


do_rootfs[nostamp] = "1"
