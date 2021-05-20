FILES_rsvg_remove = "${bindir}/rsvg* \
                     ${datadir}/pixmaps/svg-viewer.svg \
                     ${datadir}/themes"
FILES_librsvg-gtk_remove = "${libdir}/gdk-pixbuf-2.0/*/*/*.so"


FILES_${PN}_append += "${bindir}/rsvg* \
                       ${datadir}/pixmaps/svg-viewer.svg \
                       ${datadir}/themes"
FILES_${PN}_append  += "${libdir}/gdk-pixbuf-2.0/*/*/*.so"

