# RDK-RPi specific config

# hls-crypto expects nettle > 3.0 which is restricted version for RDK
EXTRA_OEMESON_remove = "-Dhls-crypto=nettle"
