do_install_append_hybrid() {
          sed -i '/ip_forward/s/^#//g' ${D}${sysconfdir}/sysctl.conf
}
