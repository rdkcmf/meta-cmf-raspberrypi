#ESDK support - Avoid conflict of file install by linux-firmware and linux-firmware-rpidistro
do_install_append_broadband_dunfell () {
	rm -rf ${D}${nonarch_base_libdir}/firmware/brcm/brcmfmac43430-sdio.raspberrypi,3-model-b.txt
	rm -rf ${D}${nonarch_base_libdir}/firmware/brcm/brcmfmac43455-sdio.raspberrypi,3-model-b-plus.txt
        rm -rf ${D}${nonarch_base_libdir}/firmware/brcm/brcmfmac43455-sdio.raspberrypi,4-model-b.txt
        rm -rf ${D}${nonarch_base_libdir}/firmware/brcm/brcmfmac43430-sdio.Hampoo-D2D3_Vi8A1.txt
        rm -rf ${D}${nonarch_base_libdir}/firmware/brcm/brcmfmac43430-sdio.bin
        rm -rf ${D}${nonarch_base_libdir}/firmware/brcm/brcmfmac43430-sdio.MUR1DX.txt
        rm -rf ${D}${nonarch_base_libdir}/firmware/brcm/brcmfmac43455-sdio.bin
        rm -rf ${D}${nonarch_base_libdir}/firmware/brcm/brcmfmac43430-sdio.AP6212.txt
}
