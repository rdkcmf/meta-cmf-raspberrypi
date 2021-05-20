# ----------------------------------------------------------------------------

SYSTEMD_TOOLS = "systemd-analyze systemd-bootchart"

# systemd-bootchart is not available as a separate package prior to OE 2.2
SYSTEMD_TOOLS_remove_daisy = "systemd-bootchart"
SYSTEMD_TOOLS_remove_krogoth = "systemd-bootchart"

# systemd-bootchart doesn't currently build with musl libc
SYSTEMD_TOOLS_remove_libc-musl = "systemd-bootchart"

IMAGE_INSTALL_append = " ${SYSTEMD_TOOLS}"

#REFPLTB-349 Needed for Firmware upgrade - to create file system of dual partition
IMAGE_INSTALL_append = " e2fsprogs breakpad-staticdev"

#nodejs support on RPI 
IMAGE_INSTALL_append_morty = " \
	${@bb.utils.contains("DISTRO_FEATURES", "nodejs", " nodejs nodejs-npm ", " ", d)} \
"

require image-exclude-files.inc

remove_unused_file() {
    for i in ${REMOVED_FILE_LIST} ; do rm -rf ${IMAGE_ROOTFS}/$i ; done
}

ROOTFS_POSTPROCESS_COMMAND_append = "remove_unused_file; "
# ----------------------------------------------------------------------------
