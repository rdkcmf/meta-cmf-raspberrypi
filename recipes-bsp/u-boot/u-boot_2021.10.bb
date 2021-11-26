require recipes-bsp/u-boot/u-boot-common.inc
require recipes-bsp/u-boot/u-boot.inc
require u-boot-include.inc

DEPENDS += "bc-native dtc-native python3-setuptools-native"

do_configure_prepend_dunfell (){
     #Need to increase the uImage size because dunfell build produced uImage size is >8M
     sed -i "s/\#define CONFIG_SYS_BOOTM_LEN\t0x800000/\#define CONFIG_SYS_BOOTM_LEN\t0x1000000/g" ${S}/common/bootm.c       
}
