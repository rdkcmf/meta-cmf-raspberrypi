SUMMARY = "Utility which shows ntp synchronisation status"

FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI = "\
            http://jaist.dl.sourceforge.net/project/ictom/ntpstat-0.2.tar.gz; \
"

SRC_URI[md5sum] = "516847d99a772305cab711339998f9ea"
SRC_URI[sha256sum] = "486fdfceb38590a9ff52ab8de1cc1ec4fc696f2e94da992e9ccf30157c32f01e"

LICENSE="GPLv2"
LIC_FILES_CHKSUM="file://COPYING;md5=479c9b73b1d47473ccace9559c370361"

do_compile() {
    ${CC} ${CFLAGS} ${LDFLAGS} ${S}/ntpstat.c -o ntpstat
}

do_install() {
    install -d ${D}${bindir}
    install -m 755 ${S}/ntpstat ${D}${bindir}
}

