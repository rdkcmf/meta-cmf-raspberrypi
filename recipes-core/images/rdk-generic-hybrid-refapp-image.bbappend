# for bluetooth
IMAGE_INSTALL_append = " bluez5 bluez5-bluetoothd"

# LG sessionmgr and camgr test Application
IMAGE_INSTALL_append = " sessionmgr-test"
IMAGE_INSTALL_append = " camgr-tests"

IMAGE_INSTALL_append = " wpeframework-ui"

IMAGE_ROOTFS_EXTRA_SPACE_append = " + 524288"
