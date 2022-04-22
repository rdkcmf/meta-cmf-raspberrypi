#!/bin/sh

CARD_DRIVER_FILE=/sys/dev/char/226\:0/device/uevent
if test -f "$CARD_DRIVER_FILE"; then
  echo "$CARD_DRIVER_FILE exists."
  driver=$(head -n 1 /sys/dev/char/226\:0/device/uevent)
  isdriver='v3d'
  awk '!/WESTEROS_DRM_CARD/' /etc/wpeframework/WPEFramework.env > temp && mv temp /etc/wpeframework/WPEFramework.env
  if [[ "$driver" == *"$isdriver"* ]]; then
    echo "WESTEROS_DRM_CARD=/dev/dri/card1"
    echo "WESTEROS_DRM_CARD=/dev/dri/card1" >> /etc/wpeframework/WPEFramework.env
  else
    echo "WESTEROS_DRM_CARD=/dev/dri/card0"
    echo "WESTEROS_DRM_CARD=/dev/dri/card0" >> /etc/wpeframework/WPEFramework.env
  fi
fi

