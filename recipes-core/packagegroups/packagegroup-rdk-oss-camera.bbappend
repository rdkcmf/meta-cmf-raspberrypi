RDEPENDS_packagegroup-rdk-oss-camera_append = "	\
                        v4l-utils \
                        packagegroup-rdk-gstreamer1 \
                        rms \
                        kvs \
                        cvr \
                        thumbnail \
                        mongoose \
                        sysint \
                        netkit-telnet \
                        parodus \
                        wpa-supplicant \
"

RDEPENDS_packagegroup-rdk-oss-camera_append = "${@oe.utils.conditional("ENABLE_PIPEWIRE", "1", "", "mediastreamer", d)}"

RDEPENDS_packagegroup-rdk-oss-camera_remove = "cryptsetup"
RDEPENDS_packagegroup-rdk-oss-camera_remove = "iksemel"
RDEPENDS_packagegroup-rdk-oss-camera_remove = "smartmontools"
RDEPENDS_packagegroup-rdk-oss-camera_remove = "dhcp-client"
RDEPENDS_packagegroup-rdk-oss-camera_remove = "dhcp-server"
RDEPENDS_packagegroup-rdk-oss-camera_remove = "dhcp-server-config"
RDEPENDS_packagegroup-rdk-oss-camera_remove = "nodejs"

RDEPENDS_packagegroup-rdk-oss-camera_remove_dunfell = "wireless-tools"

RDEPENDS_packagegroup-rdk-oss-camera_append_dunfell = " \
                        libcamera \
                        libcamera-gst \
                        pipewire \
                        pwstream \
                        webrtc \
"
