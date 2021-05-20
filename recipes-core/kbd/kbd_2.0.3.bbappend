do_install_append() {
    install -d ${D}${bindir}
    install -m 0755 ${B}/src/chvt ${D}${bindir}
    install -m 0755 ${B}/src/deallocvt ${D}${bindir}
    install -m 0755 ${B}/src/dumpkeys ${D}${bindir}
    install -m 0755 ${B}/src/fgconsole ${D}${bindir}
    install -m 0755 ${B}/src/getkeycodes ${D}${bindir}
    install -m 0755 ${B}/src/kbdinfo ${D}${bindir}
    install -m 0755 ${B}/src/kbd_mode ${D}${bindir}
    install -m 0755 ${B}/src/kbdrate ${D}${bindir}
    install -m 0755 ${B}/src/loadkeys ${D}${bindir}
    install -m 0755 ${B}/src/loadunimap ${D}${bindir}
    install -m 0755 ${B}/src/mapscrn ${D}${bindir}
    install -m 0755 ${B}/src/openvt ${D}${bindir}
    install -m 0755 ${B}/src/psfxtable ${D}${bindir}
    install -m 0755 ${B}/src/setfont ${D}${bindir}
    install -m 0755 ${B}/src/setkeycodes ${D}${bindir}
    install -m 0755 ${B}/src/setleds ${D}${bindir}
    install -m 0755 ${B}/src/setmetamode ${D}${bindir}
    install -m 0755 ${B}/src/setvtrgb ${D}${bindir}
    install -m 0755 ${B}/src/showconsolefont ${D}${bindir}
    install -m 0755 ${B}/src/showkey ${D}${bindir}
}
