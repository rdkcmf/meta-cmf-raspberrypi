# gdb 7.11.1 depends on readline features which are not present in readline 5.2
# (ie the GPLv2 version). Although gdb is itself GPLv3 and we whitelist it for
# inclusion in debug images, we don't want to whitelist the GPLv3 version of
# readline. Therefore try to build gdb using it's own internal copy of readline
# instead.
PACKAGECONFIG_remove = "readline"
