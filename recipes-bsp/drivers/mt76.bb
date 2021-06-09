SUMMARY = "Firmware for mt76 USB wifi module"
LICENSE = "Proprietary"
COMMENT = "Proprietary license allows the use of the firmware with conditions as in the license file at LIC_FILES_CHKSUM"
LIC_FILES_CHKSUM = "file://firmware/LICENSE;md5=1bff2e28f0929e483370a43d4d8b6f8e"

SRC_URI = "git://github.com/openwrt/mt76"
SRCREV = "${AUTOREV}"

S = "${WORKDIR}/git"

do_compile[noexec] = "1"

do_install () {
    install -d ${D}${base_libdir}/firmware/
    install -m 755 ${S}/firmware/mt7662*.bin  ${D}${base_libdir}/firmware/
}

FILES_${PN} += "${base_libdir}/firmware/mt7662*.bin"

