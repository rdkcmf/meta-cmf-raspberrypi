#
# Original Author (email):  John D. Frey (john.frey@cognizant.com)
# Changes Author (email), date:  John D. Frey (john.frey@cognizant.com), 10/21/2014
# Changes Author (email), date:  John D. Frey (john.frey@cognizant.com), 01/21/2015
#

SUMMARY = "HDHomeRun Support Library for Emulator QAM Tuner support"
DESCRIPTION = "Implementation of the HDHomerun Library to support having a QAM tuner to work with the RDK Emulator"
HOMEPAGE = "http://download.silicondust.com"
LICENSE = "LGPLv2.1"
LIC_FILES_CHKSUM = "file://lgpl.txt;md5=4fbd65380cdd255951079008b364516c"

DEPENDS = "libpthread-stubs"

SRCREV = "20140604"

#SRC_URI = "http://download.silicondust.com/hdhomerun/libhdhomerun_${SRCREV}.tgz;unpack=true"
SRC_URI = "https://src.fedoraproject.org/repo/pkgs/hdhomerun/libhdhomerun_20140604.tgz/13d4b0f5f20448179a5c05ee85b83786/libhdhomerun_${SRCREV}.tgz"

SRC_URI[md5sum] = "13d4b0f5f20448179a5c05ee85b83786"
SRC_URI[sha256sum] = "b01fb5df86b769e958359719f7312eabdb8e642a1c2cb78d454b28cf87c3330d"

S = "${WORKDIR}/libhdhomerun"

EXTRA_OEMAKE = "CC='${CC}' STRIP=echo OS=Linux SHARED='-shared -Wl,-soname,libhdhomerun.so.1'"

do_install() {
	install -d ${D}${includedir}/hdhomerun
	install -d ${D}${bindir}
	install -d ${D}${libdir}

	for f in ${S}/*.h; do
		install -m 0644 $f ${D}${includedir}/hdhomerun/
	done

	install -m 755 ${S}/hdhomerun_config ${D}${bindir}/

	install -m 0644 ${S}/libhdhomerun.so ${D}${libdir}/libhdhomerun.so.1
	ln -sf libhdhomerun.so.1 ${D}${libdir}/libhdhomerun.so
}
