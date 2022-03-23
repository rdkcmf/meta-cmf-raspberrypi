EXTRA_OECONF += "--disable-xfs"

EXTRA_OECONF_remove_hybrid = "--enable-ippvsource"
EXTRA_OECONF_remove_hybrid = "--enable-vodsource"
EXTRA_OECONF_remove_hybrid = "--enable-diagnostics"

PACKAGECONFIG[qam] = "--enable-emulator-qam,,virtual/sectionfilter-hal"

PACKAGECONFIG_append_hybrid = " qam"
PACKAGECONFIG_remove_hybrid = "podmgr"

PACKAGECONFIG ??= ""
