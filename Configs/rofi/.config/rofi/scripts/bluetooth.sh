#!/usr/bin/env bash

powered=$(bluetoothctl show | grep "Powered:" | awk '{print $2}')

if [[ $powered == "yes" ]]; then
    action=$(printf "\uf067 Enable Bluetooth\n\uf00d Disable Bluetooth\n\uf293 Pair New Device\n\uf293 Connect Device" | rofi -dmenu -p "" -theme ~/.config/rofi/themes/bluetooth.rasi)
    [[ -z "$action" ]] && exit
    action=$(awk '{for(i=2;i<=NF;i++) printf "%s%s", $i, (i<NF?OFS:"")}' <<< "$action")
    case $action in
        "Enable Bluetooth")
            bluetoothctl power on
            ;;
        "Disable Bluetooth")
            bluetoothctl power off
            ;;
        "Pair New Device")
            rofi -e "Scanning... press any key to stop" -theme ~/.config/rofi/themes/bluetooth.rasi &
            scan_pid=$!
            bluetoothctl scan on &
            scan_on_pid=$!
            read -rsn1
            kill $scan_pid $scan_on_pid 2>/dev/null
            wait $scan_on_pid 2>/dev/null
            device=$(bluetoothctl devices | rofi -dmenu -p "" -theme ~/.config/rofi/themes/bluetooth.rasi | awk '{print $2}')
            if [[ -n $device ]]; then
                bluetoothctl pair "$device"
                bluetoothctl trust "$device"
                bluetoothctl connect "$device"
            fi
            ;;
        "Connect Device")
            device=$(bluetoothctl devices | rofi -dmenu -p "" -theme ~/.config/rofi/themes/bluetooth.rasi | awk '{print $2}')
            if [[ -n $device ]]; then
                bluetoothctl connect "$device"
            fi
            ;;
    esac
else
    action=$(printf "\uf067 Enable Bluetooth" | rofi -dmenu -p "" -theme ~/.config/rofi/themes/bluetooth.rasi)
    [[ -z "$action" ]] && exit
    action=$(awk '{for(i=2;i<=NF;i++) printf "%s%s", $i, (i<NF?OFS:"")}' <<< "$action")
    if [[ $action == "Enable Bluetooth" ]]; then
        bluetoothctl power on
    fi
fi
