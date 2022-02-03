do_install_append_dunfell () {
        sed -i 's/ResidentApp/LightningApp/g' ${D}/lib/rdk/residentApp.sh
}
