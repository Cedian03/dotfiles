#!/usr/bin/env bash

entries=$(printf "\uf011 Power Off\n\uf021 Reboot\n\uf023 Lock\n\uf186 Sleep")

selected=$(echo -e "$entries" | rofi -dmenu -p "" -theme ~/.config/rofi/themes/powermenu.rasi)
[[ -z "$selected" ]] && exit

action=$(awk '{for(i=2;i<=NF;i++) printf "%s%s", $i, (i<NF?OFS:"")}' <<< "$selected")

case $action in
  "Power Off") systemctl poweroff ;;
  Reboot) systemctl reboot ;;
  Lock) loginctl lock-session ;;
  Sleep) systemctl suspend ;;
esac
