SRC_URI += "file://0001-westeros-sink-1080p.patch;apply=no"

# we need to patch to code for appmanager
do_westeros_sink_patches() {
    cd ${S}
    if [ ! -e patch_applied ]; then
        bbnote "Patching 0001-westeros-sink-1080p.patch"
        patch -p1 < ${WORKDIR}/0001-westeros-sink-1080p.patch || echo "ERROR or Patch already applied"
        touch patch_applied
    fi
}
addtask westeros_sink_patches after do_unpack before do_configure
