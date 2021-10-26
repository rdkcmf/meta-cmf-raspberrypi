require recipes-kernel/linux-libc-headers/linux-libc-headers.inc

#SRC_URI[md5sum] = "ce9b2d974d27408a61c53a30d3f98fb9"
#SRC_URI[sha256sum] = "bf338980b1670bca287f9994b7441c2361907635879169c64ae78364efc5f491"

SRC_URI[md5sum] = "0e65898ebd1f58eaa52e5124e8cbe4b0"
SRC_URI[sha256sum] = "769e57a0fa218589fa2f8460b8682eb784a72718c7a3d95295f382a77902ae79"

LIC_FILES_CHKSUM = "file://COPYING;md5=6bc538ed5bd9a7fc9398086aedcd7e46"

do_install_armmultilib () {
	oe_multilib_header asm/auxvec.h asm/bitsperlong.h asm/byteorder.h asm/fcntl.h asm/hwcap.h asm/ioctls.h asm/kvm_para.h asm/mman.h asm/param.h asm/perf_regs.h asm/bpf_perf_event.h
	oe_multilib_header asm/posix_types.h asm/ptrace.h  asm/setup.h  asm/sigcontext.h asm/siginfo.h asm/signal.h asm/stat.h  asm/statfs.h asm/swab.h  asm/types.h asm/unistd.h
}
