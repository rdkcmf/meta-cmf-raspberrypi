# Note: This feature is for developers ONLY.
# Please do not forget to set BB_ENV_EXTRAWHITE before
# launching the yocto build.
# `export BB_ENV_EXTRAWHITE="${BB_ENV_EXTRAWHITE} RDK_ROOT_PATH"`
#
INHERIT += "externalsrc"

EXTERNALSRC_pn-westeros-sink = "${@'${RDK_ROOT_PATH}/components/opensource/westeros' if (os.path.isdir('${RDK_ROOT_PATH}/components/opensource/westeros')) else ''}"
