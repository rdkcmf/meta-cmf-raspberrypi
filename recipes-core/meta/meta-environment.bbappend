SUMMARY = "Additional variables for environment files for SDK"

do_add_env_variable() {
   sed -i '/CROSS_COMPILE/a export RDK_FSROOT_PATH="$SDKTARGETSYSROOT"' ${SDK_OUTPUT}${SDKPATH}/environment-setup-${REAL_MULTIMACH_TARGET_SYS}
}

addtask add_env_variable before do_install after generate_content
do_add_env_variable[prefuncs] += "do_generate_content"
