require meta-rdk-broadband/recipes-ccsp/ccsp/ccsp_common_rpi.inc

do_install_append () {
    # Test and Diagonastics XML 
       install -m 644 ${S}/config/TestAndDiagnostic_arm.XML ${D}/usr/ccsp/tad/TestAndDiagnostic.XML
       install -m 644 ${S}/scripts/selfheal_reset_counts.sh ${D}/usr/ccsp/tad/selfheal_reset_counts.sh

}
