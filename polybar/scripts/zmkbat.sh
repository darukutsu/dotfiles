#!/usr/bin/env sh

# More info on
# https://ukbaz.github.io//howto/python_gio_1.html
# https://gist.github.com/madushan1000/9744eb6350a5dd9685fb6bfbb25fbb8a

MAC_ADDR=D0_AD_70_06_3E_45
DBUS_PATH=/org/bluez/hci2
L_PATH=service0010/char0011
R_PATH=service0015/char0016

# do this only to determine path although default should be good
# NOTE: for some reason it writes 0 every time unless this function runs and unlocks something
#       so recommend to run this script once every hour
for path in $(busctl tree org.bluez | grep -o "/org/bluez/hci2/dev_$MAC_ADDR/service.*/char.*"); do
  busctl get-property org.bluez "$path" org.bluez.GattCharacteristic1 UUID 1>&2 >/dev/null &&
    busctl call org.bluez "$path" org.bluez.GattCharacteristic1 ReadValue a{sv} 0 1>&2 >/dev/null
  #echo $path
done

left_battery=$(
  busctl introspect org.bluez $DBUS_PATH/dev_$MAC_ADDR/$L_PATH |
    grep '^.Value' | grep -Eo '[0-9]+' | tail -n1
  #busctl introspect org.bluez /org/bluez/hci0/dev_$MAC_ADDR |
  #grep 'Percentage' | grep -Eo '[0-9]+'
)

# 00002a19-0000-1000-8000-00805f9b34fb
right_battery=$(
  busctl introspect org.bluez $DBUS_PATH/dev_$MAC_ADDR/$R_PATH |
    grep '^.Value' | grep -Eo '[0-9]+' | tail -n1
)

if [ -n "$right_battery" ]; then
  echo " $left_battery  $right_battery"
else
  echo ""
fi
