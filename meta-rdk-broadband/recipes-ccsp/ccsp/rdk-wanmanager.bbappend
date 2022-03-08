CFLAGS_append = " -D_PLATFORM_RASPBERRYPI_"

do_configure_prepend() {
	if ${@bb.utils.contains('DISTRO_FEATURES', 'rdkb_wan_manager', 'false', 'true', d)}; then
        (python ${STAGING_BINDIR_NATIVE}/dm_pack_code_gen.py ${S}/config/RdkWanManager.xml ${S}/source/WanManager/dm_pack_datamodel.c)
	fi
}
