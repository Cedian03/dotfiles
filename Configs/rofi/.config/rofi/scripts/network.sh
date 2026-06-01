#!/usr/bin/env bash

status=$(nmcli -t -f WIFI g)
wifi_icon=$(printf "\uf1eb")

if [[ $status == "enabled" ]]; then
    action=$(printf "\uf067 Enable WiFi\n\uf00d Disable WiFi\n\uf1eb Select Network" | rofi -dmenu -p "" -theme ~/.config/rofi/themes/network.rasi)
    [[ -z "$action" ]] && exit
    action=$(awk '{for(i=2;i<=NF;i++) printf "%s%s", $i, (i<NF?OFS:"")}' <<< "$action")
    case $action in
        "Enable WiFi")
            nmcli radio wifi on
            ;;
        "Disable WiFi")
            nmcli radio wifi off
            ;;
        "Select Network")
            network=$(nmcli -t -f SSID,SECURITY,SIGNAL dev wifi list | awk -F: -v ic="$wifi_icon" '{sig=$3; bar=""; for(i=0;i<int(sig/20);i++) bar=bar"█"; printf "%s %-30s %-10s %s\n", ic, $1, $2, bar}' | rofi -dmenu -p "" -theme ~/.config/rofi/themes/network.rasi | awk '{print $2}')
            if [[ -n $network ]]; then
                nmcli dev wifi connect "$network"
            fi
            ;;
    esac
else
    action=$(printf "\uf067 Enable WiFi" | rofi -dmenu -p "" -theme ~/.config/rofi/themes/network.rasi)
    [[ -z "$action" ]] && exit
    action=$(awk '{for(i=2;i<=NF;i++) printf "%s%s", $i, (i<NF?OFS:"")}' <<< "$action")
    if [[ $action == "Enable WiFi" ]]; then
        nmcli radio wifi on
    fi
fi
