RDEPENDS_packagegroup-rdk-baserootfs_append_rpi = "\
    e2fsprogs-resize2fs \
"

RDEPENDS_packagegroup-rdk-baserootfs_remove = "${@bb.utils.contains('DISTRO_FEATURES', 'ipclient', 'xupnp', '', d)}"
