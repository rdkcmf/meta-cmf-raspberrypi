FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI += "file://0001-xfinity-remote-key_menu.patch \
            file://0002-keymaping-to-exit.patch \
           "

export PLATFORM = "rpi"
export PXSCENE_PLATFORM_DEFINES = " -DPXSCENE_DISABLE_PXCONTEXT_EXT -DENABLE_PX_WAYLAND_RPC" 
