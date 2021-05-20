FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"
SUMMARY = "This receipe installs wizardkit UI Apps. Wizardkit Media Client devices use Wizardkit UI App to interact with Hybrid device"
SECTION = "rdkapps/wizardkit"

LICENSE = "Apache-2.0 & MIT"
LIC_FILES_CHKSUM = "file://LICENSE;md5=5e0c7b765dc35fcf6358059e1bfad016" 

SRCREV = "${AUTOREV}"

PV = "${RDK_RELEASE}+git${SRCPV}"

SRC_URI = "${CMF_GIT_ROOT}/rdk/components/generic/rdkapps;protocol=${CMF_GIT_PROTOCOL};branch=${CMF_GIT_BRANCH}"

SRC_URI_append = " \
        file://wizardkit.service \
		"

S = "${WORKDIR}/git"

inherit systemd

#if wizardkit is to be cofiured to autostart at build time, uncomment the following line
#SYSTEMD_SERVICE_${PN} = "wizardkit.service"

DEPENDS = "lighttpd"

export RDK_FSROOT_PATH = '='
export FSROOT = '='

CFLAGS_append = " -fPIC "
CXXFLAGS_append = " -fPIC "

THISDIR := "${@os.path.dirname(d.getVar('FILE', True))}"
do_configure_prepend_daisy () {
cp ${THISDIR}/${PN}/wizardkit.service ${WORKDIR}/
}


do_install(){
    # install cgi scripts
	install -d ${D}/opt/www/cgi-bin 
	install -m 0755 ${S}/wizardkit/cgi-bin/*.sh ${D}/opt/www/cgi-bin/
	# create wizrd kit folder and copy all html ui there
	install -d ${D}/opt/www/wizardkit/
	# install html files
	install -d ${D}/opt/www/wizardkit/ui
	install -m 0755 ${S}/wizardkit/ui/*.html ${D}/opt/www/wizardkit/ui/
    # install PNG images
	install -d ${D}/opt/www/wizardkit/ui/Cover\ Art
	install -m 0755 ${S}/wizardkit/ui/Cover\ Art/*.png ${D}/opt/www/wizardkit/ui/Cover\ Art/
    # install resources
	install -d ${D}/opt/www/wizardkit/ui/resources
	install -m 0755 ${S}/wizardkit/ui/resources/*.png ${D}/opt/www/wizardkit/ui/resources/
    # install js scripts
	install -d ${D}/opt/www/wizardkit/ui/scripts
	install -m 0755 ${S}/wizardkit/ui/scripts/*.js ${D}/opt/www/wizardkit/ui/scripts/
    # install css styles
	install -d ${D}/opt/www/wizardkit/ui/styles
	install -m 0755 ${S}/wizardkit/ui/styles/*.css ${D}/opt/www/wizardkit/ui/styles/
	#install the service don't enable it, leave it to the user to run or enable
	install -d ${D}${systemd_unitdir}/system/
	install -m 777 ${WORKDIR}/wizardkit.service ${D}${systemd_unitdir}/system/ 
}

FILES_${PN} += "/opt/www/wizardkit \
                /opt/www/cgi-bin \
				/lib/systemd/system/wizardkit.service \
        "
