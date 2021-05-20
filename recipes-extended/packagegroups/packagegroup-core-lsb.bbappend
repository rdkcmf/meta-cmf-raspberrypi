RDEPENDS_packagegroup-core-lsb-desktop_remove = "\
    libxt \
    libxxf86vm \
    libglu \
    libxi \
    libxtst \
    libx11-locale \
    xorg-minimal-fonts \
    gtk+ \
    ${QT4PKGS} \
"

QT4PKGS_remove = " \
    libqtcore4 \
    libqtgui4 \
    libqtsql4 \
    libqtsvg4 \
    libqtxml4 \
    libqtnetwork4 \
    qt4-plugin-sqldriver-sqlite \
    ${@bb.utils.contains("DISTRO_FEATURES", "opengl", "libqtopengl4", "", d)} \
    opengl \
    libqtopengl4 \
    "

RDEPENDS_packagegroup-core-lsb-runtime-add_remove = "\
    mkfontdir \
    "

RDEPENDS_packagegroup-core-sys-extended_remove = "\
    parted \
    wget \
    which \
    "

RDEPENDS_packagegroup-core-lsb-core_remove = "\
    ghostscript \
    msmtp \
    xdg-utils \
    "

REQUIRED_DISTRO_FEATURES_remove = " x11"

