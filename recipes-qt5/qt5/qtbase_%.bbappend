# meta-raspberrypi dunfell branch enables kms PACKAGECONFIG based on latest qtbase version
# but RDK always points to qtbase v 5.1.1 where kms package is depend with kms recipe
# also qtbase is not used in RDK so, kms package can be blindly removed
PACKAGECONFIG_GL_remove = "kms"