FILESEXTRAPATHS_prepend := "${THISDIR}/${BPN}:"

DEPENDS_hybrid = "${RMFAPP_MEDIACLIENT_DEPENDS} ${RMFAPP_HYBRID_DEPENDS}"

INCLUDE_DIRS = " \
	-I${PKG_CONFIG_SYSROOT_DIR}/usr/include/rdk/iarmmgrs/sysmgr \
	-I${PKG_CONFIG_SYSROOT_DIR}/usr/include/rdk/iarmbus \
	-I${PKG_CONFIG_SYSROOT_DIR}/usr/include/openssl-0.9.8j"

CFLAGS_append_hybrid = " -O2 -pipe -g \
	-feliminate-unused-debug-types \
	-DRDK_EMULATOR  \
	-DRMF_OSAL_LITTLE_ENDIAN \
	-DDISABLE_XFS -DUSE_OOBMGR \
	-DDISABLE_INBAND_MGR \
	-DUSE_QAMSRC \
	-DQAMSRC_FACTORY \
	-DUSE_HNSINK \
	-DUSE_HNSRC \
	-DUSE_DVR \
	-DUSE_MEDIAPLAYERSINK \
	-DRMF_STREAMER \
	-DRECORDER_SUPPORT \
	-DOOBSI_SUPPORT \
	-DDEBUG_CONF_FILE="\"debug.ini\"" \
	-DENV_CONF_FILE="\"rmfconfig.ini\"" \
	-fno-builtin-memcpy \
	-fno-strict-aliasing \
	-DFORMAT_ELF \
	-D_INTERNAL_PCI_ \
	-fPIC \
	${INCLUDE_DIRS}"

CXXFLAGS_append_hybrid = " ${CFLAGS}"

EXTRA_OECONF_append_hybrid = " --enable-headless --enable-emulator-qam --enable-transcoderfilter --enable-rmfproxyservice --enable-dumpfilesink --enable-hnsink --enable-dvr"

EXTRA_OECONF_remove_hybrid = " --enable-pod"
