RDEPENDS_packagegroup-rdk-gstreamer1_append = " \
						gstreamer1.0-plugins-good-video4linux2 \
						gstreamer1.0-plugins-bad \
                                                gstreamer1.0-omx \
                                                gstreamer1.0-plugins-base-app \
                                                gstreamer1.0-plugins-good-souphttpsrc \
                                                gstreamer1.0-plugins-bad-videoparsersbad \
                                                gstreamer1.0-plugins-good-rtp \
                                                gstreamer1.0-plugins-good-udp \
					      "

RDEPENDS_packagegroup-rdk-gstreamer1_append_morty = " \
                                                gstreamer1.0-plugins-bad-opengl \
                                                faad2 \
                                                gstreamer1.0-plugins-bad-faad \
                                                "

RDEPENDS_packagegroup-rdk-gstreamer1_append_dunfell = " \
                                                gstreamer1.0-plugins-base-opengl \
                                                ${@bb.utils.contains('LICENSE_FLAGS_WHITELIST', 'commercial', 'faad2', '', d)} \
                                                ${@bb.utils.contains('LICENSE_FLAGS_WHITELIST', 'commercial', 'gstreamer1.0-plugins-bad-faad', '', d)} \
						      "
