RDEPENDS_packagegroup-rdk-oss-camera_append = "	\
			                        v4l-utils \
                        			packagegroup-rdk-gstreamer1 \
						rms \
						kvs \
                        			cvr \
                        			thumbnail \
						mongoose \
						mediastreamer \
						sysint \
						netkit-telnet \
						parodus \
						wpa-supplicant \
                	                      "

RDEPENDS_packagegroup-rdk-oss-camera_remove = " \
						cryptsetup \
						iksemel \
						smartmontools \
						dhcp-client \
						dhcp-server \
						dhcp-server-config \
						nodejs \
					      "

RDEPENDS_packagegroup-rdk-oss-camera_remove_dunfell = " \
                                                        wireless-tools \
                                                      "

RDEPENDS_packagegroup-rdk-oss-camera_append_dunfell = " \
                                                        libcamera \
							libcamera-gst \
							pipewire \
                                                      "
