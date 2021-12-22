
LINUX_RPI_KMETA_BRANCH ?= "yocto-5.4"

SRCREV_machine = "dde641c7f82be495aac103920e8d0348a2d40b72"
SRCREV_meta = "5d52d9eea95fa09d404053360c2351b2b91b323b"

require android-raspberrypi_5.10.inc

SRC_URI += "file://powersave.cfg \
             file://android-drivers.cfg \
            "
