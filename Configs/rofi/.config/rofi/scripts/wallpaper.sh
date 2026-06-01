#!/usr/bin/env bash

wall_dir="${WALLPAPER_DIR:-$HOME/Pictures/wallpapers}"

[[ -d $wall_dir ]] || {
    rofi -e "Directory $wall_dir not found" -theme ~/.config/rofi/themes/wallpaper.rasi
    exit 1
}

entries = n(find "$wall_dir" -type f \( -iname '*.jpg' -o -iname '*.png' -o -iname '*.jpeg' \) | sort)

selected=$(printf "%s\n" "${entries[@]}" | rofi -dmenu -p "" -show-icons -theme ~/.config/rofi/themes/wallpaper.rasi)
[[ -z "$selected" ]] && exit

wallpaper="$wall_dir/$selected"
[[ -f $wallpaper ]] && hyprctl hyprpaper wallpaper ",$wallpaper"
