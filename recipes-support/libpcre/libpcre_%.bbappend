EXTRA_OECONF += "--enable-pcre32"
PACKAGECONFIG_append = " pcre8 pcre32 unicode-properties"

PACKAGECONFIG[pcre8] = "--enable-pcre8,--disable-pcre8"
PACKAGECONFIG[pcre16] = "--enable-pcre16,--disable-pcre16"
PACKAGECONFIG[pcre32] = "--enable-pcre32,--disable-pcre32"
