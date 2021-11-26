require ccsp_common_rpi.inc

CFLAGS += " -DDHCPV4_CLIENT_UDHCPC -DDHCPV6_CLIENT_DIBBLER "
CFLAGS_remove_aarch64 = " -Werror "
LDFLAGS_append_aarch64 = " -lutctx"
