#!/usr/bin/env bash
 
if [[ -n "$SOUND_DISABLE_UPNP" ]]; then
  echo "UPnP is disabled, exiting..."
  exit 0
fi

# --- ENV VARS ---
# SOUND_DEVICE_NAME: Set the device broadcast name for UPnP
SOUND_DEVICE_NAME=${SOUND_DEVICE_NAME:-"balenaSound UPnP $(hostname | cut -c -4)"}

UPNP_UUID=`ip link show | awk '/ether/ {print "salt:)-" $2}' | head -1 | md5sum | awk '{print $1}'`

echo "Starting UPnP plugin..."
echo "Device name: $SOUND_DEVICE_NAME"
echo "UPNP UUID: $UPNP_UUID"

exec /usr/bin/gmediarender \
  --friendly-name "$SOUND_DEVICE_NAME" \
  -u "$UPNP_UUID" \
  --port=49494
