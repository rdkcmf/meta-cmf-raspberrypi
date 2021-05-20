LIC_FILES_CHKSUM_dunfell = "file://hal/hal_com_c2h.h;md5=662fa96812921f188274143f6d501f27;endline=19"

SRCREV_dunfell = "b7faffdd77767269770b79876f88dd1145b6a630"

do_configure_prepend_dunfell() {
	sed -i "s/CONFIG_PLATFORM_ARM_RPI = n/CONFIG_PLATFORM_ARM_RPI = y/g" ${WORKDIR}/git/Makefile
	sed -i "s/CONFIG_PLATFORM_I386_PC = y/CONFIG_PLATFORM_I386_PC = n/g" ${WORKDIR}/git/Makefile
}

do_compile_dunfell() {
        unset CFLAGS CPPFLAGS CXXFLAGS LDFLAGS CC LD CPP
	oe_runmake 'M={D}${base_libdir}/modules/${KERNEL_VERSION}/kernel/drivers/net/wireless' \
        'KERNEL_SOURCE=${STAGING_KERNEL_DIR}' \
        'LINUX_SRC=${STAGING_KERNEL_DIR}' \
        'KDIR=${STAGING_KERNEL_DIR}' \
        'KERNDIR=${STAGING_KERNEL_DIR}' \
        'KSRC=${STAGING_KERNEL_DIR}' \
        'KERNEL_VERSION=${KERNEL_VERSION}' \
        'KVER=${KERNEL_VERSION}' \
        'CC=${KERNEL_CC}' \
        'AR=${KERNEL_AR}' \
        'LD=${KERNEL_LD}'
}
