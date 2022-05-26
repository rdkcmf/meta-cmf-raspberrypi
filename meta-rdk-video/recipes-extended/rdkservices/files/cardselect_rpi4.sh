#!/bin/sh

CARD_DRIVER_FILE=/sys/dev/char/226\:0/device/uevent
if test -f "$CARD_DRIVER_FILE"; then
  echo "$CARD_DRIVER_FILE exists."
  driver=$(head -n 1 /sys/dev/char/226\:0/device/uevent)
  isdriver='v3d'
  if [[ "$driver" == *"$isdriver"* ]]; then
    echo "WESTEROS_DRM_CARD=/dev/dri/card1"
    sed -i 's/card0/card1/g' /etc/wpeframework/WPEFramework.env
    sed -i 's/card0/card1/g' /lib/systemd/system/wpeframework.service.d/wpeframework.conf
  else
    echo "WESTEROS_DRM_CARD=/dev/dri/card0"
    sed -i 's/card1/card0/g' /etc/wpeframework/WPEFramework.env
    sed -i 's/card1/card0/g' /lib/systemd/system/wpeframework.service.d/wpeframework.conf
  fi
fi
