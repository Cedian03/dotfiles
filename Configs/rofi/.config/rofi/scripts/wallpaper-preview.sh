#!/usr/bin/env bash
wall_dir="$1"
selected="$2"
[[ -z "$selected" || ! -f "$wall_dir/$selected" ]] && exit
hyprctl hyprpaper wallpaper ","$wall_dir/$selected" 2>/dev/null
