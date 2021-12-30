require ccsp_common_rpi.inc

CFLAGS += " -DDHCPV4_CLIENT_UDHCPC -DDHCPV6_CLIENT_DIBBLER "

LDFLAGS_append_aarch64 = " -lutctx"
