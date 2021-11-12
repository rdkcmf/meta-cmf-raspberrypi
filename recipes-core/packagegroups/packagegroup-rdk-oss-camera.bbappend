RDEPENDS_packagegroup-rdk-oss-camera_append = "	\
			                        v4l-utils \
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
							pipewire \
                                                      "
