require ccsp_common_rpi.inc

CFLAGS_remove_aarch64 = " -Werror "
LDFLAGS_append_aarch64 = " -lutctx"
