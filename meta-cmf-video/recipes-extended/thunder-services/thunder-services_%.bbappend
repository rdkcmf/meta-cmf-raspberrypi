# Raspberrypi specific configuration for Thunder nano services

PACKAGECONFIG_append_rpi = " firmwarecontrol"

# Change the image download path
WPE_FIRMWARECONTROL_DOWNLOAD_LOCATION = "/var/lib"