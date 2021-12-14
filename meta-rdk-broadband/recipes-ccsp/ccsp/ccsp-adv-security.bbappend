require ccsp_common_rpi.inc

EXTRA_OEMAKE += "'SSP_LDFLAGS=${SSP_LDFLAGS}'"
SSP_LDFLAGS = " \
    -lhal_platform -lcm_mgnt \
"
