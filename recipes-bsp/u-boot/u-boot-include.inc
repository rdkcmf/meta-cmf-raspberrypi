SRC_URI_remove = "git://git.denx.de/u-boot.git \
           file://remove-redundant-yyloc-global.patch \
           file://CVE-2020-8432.patch \
           file://CVE-2020-10648-1.patch \
           file://CVE-2020-10648-2.patch \
          "
LIC_FILES_CHKSUM_remove = "file://Licenses/README;md5=30503fd321432fc713238f582193b78e"
LIC_FILES_CHKSUM = "file://Licenses/README;md5=5a7450c57ffe5ae63fd732446b988025"

SRCREV = "d80bb749fab53da72c4a0e09b8c2d2aaa3103c91"

SRC_URI += "git://git.denx.de/u-boot.git;branch=master \
          "
