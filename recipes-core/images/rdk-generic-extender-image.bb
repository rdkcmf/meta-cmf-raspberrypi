SUMMARY = "A image for the RDK extender yocto build"

inherit rdk-image
require recipes-core/images/add-non-root-user-group.inc

IMAGE_FEATURES_remove = "read-only-rootfs"

IMAGE_ROOTFS_SIZE = "8192"

IMAGE_INSTALL += " \
   packagegroup-core-boot \
   devmem2 \
   lttng-tools \
   pptp-linux \
   rp-pppoe  \
   iputils \
   btrfs-tools \
   util-linux-readprofile \
   wireless-tools \
   cryptsetup \
   coreutils \
   dosfstools \
   e2fsprogs \
   fftw \
   hostapd \
   wpa-supplicant \
   iproute2 \
   libpcap \
   nfs-utils \
   openssl \
   rpcbind \
   python-core \
   sg3-utils \
   squashfs-tools \
   valgrind \
   testfloat \
   dhcp-server \
   iptables \
   rdk-logger \
   ${SYSTEMD_TOOLS} \
   php \
   libmcrypt \
   bzip2 \
   nmap \
   libpcap \
   tcpdump \
   ebtables \
   iw \
   bc \
   ieee1905 \
   opensync \
   openvswitch \
   libcap \
   bridge-utils \
   strace \
   wpa-supplicant \
   dropbear \
   mt76 \
"

SYSTEMD_TOOLS = "systemd-analyze systemd-bootchart"
# systemd-bootchart doesn't currently build with musl libc
SYSTEMD_TOOLS_remove_libc-musl = "systemd-bootchart"

do_rootfs[nostamp] = "1"
