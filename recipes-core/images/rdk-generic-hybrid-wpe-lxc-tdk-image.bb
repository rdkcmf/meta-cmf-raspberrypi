require recipes-core/images/rdk-generic-hybrid-wpe-lxc-image.bb
require recipes-core/images/add-non-root-user-group.inc

IMAGE_FEATURES += "tdk"

IMAGE_INSTALL += " \
        packagegroup-tdk \
        "
PACKAGE_EXCLUDE_pn-rdk-generic-hybrid-wpe-tdk-image = "${@bb.utils.contains('DISTRO_FEATURES','ENABLE_IPK','packagegroup-tdk','',d)}"
