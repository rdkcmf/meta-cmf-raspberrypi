SRC_URI_dunfell = "git://github.com/gordboy/rtl8812au-5.6.4.2.git;protocol=https"
SRCREV_dunfell = "3110ad65d0f03532bd97b1017cae67ca86dd34f6"
do_configure_prepend() {
	sed -i "s/CONFIG_PLATFORM_ARM_RPI = n/CONFIG_PLATFORM_ARM_RPI = y/g" ${WORKDIR}/git/Makefile
	sed -i "s/CONFIG_PLATFORM_I386_PC = y/CONFIG_PLATFORM_I386_PC = n/g" ${WORKDIR}/git/Makefile
	sed -i "/\$(CONFIG_PLATFORM_ARM_RPI)/a EXTRA_CFLAGS += -DCONFIG_CONCURRENT_MODE" ${WORKDIR}/git/Makefile
}

do_configure_append_dunfell() {
        touch ${B}/rtl8812au.ko
}
do_install_append_dunfell() {
        rm ${D}/lib/modules/${KERNEL_VERSION}/rtl8812au.ko
	rm ${B}/rtl8812au.ko
        install -m 0755 ${B}/8812au.ko ${D}/lib/modules/${KERNEL_VERSION}/8812au.ko
}
