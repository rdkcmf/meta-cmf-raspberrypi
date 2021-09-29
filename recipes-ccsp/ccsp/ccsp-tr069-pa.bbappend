require ccsp_common_rpi.inc
CFLAGS_remove_aarch64= " -Werror"
LDFLAGS += "-Wl,--no-as-needed -lulog"

#This is workaround for missing do_patch when RDK uses external sources
SRC_URI_remove_dunfell = "file://0001-openssl-1.1.x-compatibility.patch"

SRC_URI_append_dunfell = " file://0001-openssl-1.1.x-compatibility.patch;apply=no"

do_rpi_patches() {
    cd ${S}
        if [ ! -e dunfell_patch_applied ]; then
                  if [ "${@bb.utils.contains('DISTRO_CODENAME', 'dunfell', 'dunfell', '', d)}" = "dunfell" ] ; then
                         patch -p1 < ${WORKDIR}/0001-openssl-1.1.x-compatibility.patch
                  fi
            touch dunfell_patch_applied
        fi
}

addtask rpi_patches after do_unpack before do_configure

do_install_append () {
    # Config files and scripts
    install -m 644 ${S}/config/ccsp_tr069_pa_certificate_cfg_arm.xml ${D}/usr/ccsp/tr069pa/ccsp_tr069_pa_certificate_cfg.xml
    install -m 644 ${S}/config/ccsp_tr069_pa_cfg_arm.xml ${D}/usr/ccsp/tr069pa/ccsp_tr069_pa_cfg.xml
    install -m 644 ${S}/config/ccsp_tr069_pa_mapper_arm.xml ${D}/usr/ccsp/tr069pa/ccsp_tr069_pa_mapper.xml
    install -m 644 ${S}/config/sdm_arm.xml ${D}/usr/ccsp/tr069pa/sdm.xml
    install -m 644 ${S}/arch/intel_usg/config/url ${D}/usr/ccsp/tr069pa/url

    install -d ${D}/fss/gw/
    install -d ${D}/fss/gw/usr/ccsp/
    install -d ${D}/etc
    install -m 777 ${D}/usr/bin/CcspTr069PaSsp -t ${D}/usr/ccsp/tr069pa

    ln -sf /version.txt ${D}/fss/gw/version.txt
    ln -sf /usr/ccsp/tr069pa/ ${D}/fss/gw/usr/ccsp/tr069pa
    ln -sf /usr/ccsp/tr069pa/sdm.xml ${D}/usr/bin/sdm.xml
    ln -sf /usr/ccsp/tr069pa/url ${D}${sysconfdir}/url
    echo "5555" > ${D}/usr/ccsp/tr069pa/sharedkey
}

FILES_${PN}-ccsp += " \
    ${prefix}/ccsp/tr069pa/CcspTr069PaSsp \
    ${prefix}/ccsp/tr069pa/url \
"

FILES_${PN} += " \
    /fss/gw/usr/ccsp/ \
    /fss/gw/version.txt \
    /etc/url \
"

do_package_qa(){
}
