FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI_append = "file://defconfig_conntrack.patch \
          "
# command line for raspberrypi
CMDLINE = "dwc_otg.lpm_enable=0 console=ttyAMA0,115200 console=tty1 root=/dev/mmcblk0p2 rootfstype=ext4 rootwait"

# Add the kernel debugger over console kernel command line option if enabled
CMDLINE_append = ' ${@base_conditional("ENABLE_KGDB", "1", "kgdboc=ttyAMA0,115200", "", d)}'

# Remove raspberry logos from console. To remove the raspberry logos from console, set this variable to "1" in a conf file.
CMDLINE_append = ' ${@base_conditional("REMOVE_LOGO", "1", "logo.nologo", "", d)}'

# Disable tty1 interface to prevent console logging to TV. To remove console logging from TV, set this variable to "1" in a conf file.
CMDLINE_remove = ' ${@base_conditional("REMOVE_TTY1", "1", "console=tty1", "", d)}'
