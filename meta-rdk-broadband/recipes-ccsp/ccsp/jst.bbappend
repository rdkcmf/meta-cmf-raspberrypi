
LDFLAGS_aarch64 += " -Wl,--no-as-needed"

do_configure_prepend_aarch64 () {
	sed -i "s/format_s\[loop2-1\]=0\;/\/\/format_s\[loop2-1\]=0\;/g" ${S}/source/jst_cosa.c
}

do_install_append_aarch64 () {
    sed -i '/return \$arr.pop()/i  \$arr.pop();' ${D}/usr/www2/includes/php.jst
}
