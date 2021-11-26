require ccsp_common_rpi.inc

export PLATFORM_RASPBERRYPI_ENABLED="yes"

FILES_${PN} += " \
    /usr/bin/gw_prov_utopia \
"
