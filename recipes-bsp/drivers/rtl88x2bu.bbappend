SRCREV_dunfell = "66aae0e630e9886acee2386c0623ca479130c8b8"

do_configure_prepend() {
	sed -i "s/CONFIG_PLATFORM_ARM_RPI = n/CONFIG_PLATFORM_ARM_RPI = y/g" ${WORKDIR}/git/Makefile
	sed -i "s/CONFIG_PLATFORM_I386_PC = y/CONFIG_PLATFORM_I386_PC = n/g" ${WORKDIR}/git/Makefile
	sed -i "/\$(CONFIG_PLATFORM_ARM_RPI)/a EXTRA_CFLAGS += -DCONFIG_CONCURRENT_MODE" ${WORKDIR}/git/Makefile
}
