CFLAGS_remove = "${@bb.utils.contains('DISTRO_FEATURES','rdkb_wan_manager','',bb.utils.contains('DISTRO_FEATURES', 'fwupgrade_manager', '-DFEATURE_FWUPGRADE_MANAGER', '', d),d)}"
