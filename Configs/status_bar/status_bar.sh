# Status bar script

output=""

# Media

if [ $(which playerctl) ]; then
    media_status=$(playerctl status)
    media_artist=$(playerctl metadata artist)
    media_title=$(playerctl metadata title)

    if [ $media_status = "Playing" ]; then
        output="${output} > $media_artist - $media_title | "
    elif [ "$media_status" = "Paused" ]; then
        output="${output} # $media_artist - $media_title | "
    fi
fi

# Battery

battery_charge=$(upower --show-info $(upower --enumerate | grep 'BAT') | egrep "percentage" | awk '{print $2}')
battery_status=$(upower --show-info $(upower --enumerate | grep 'BAT') | egrep "state" | awk '{print $2}')

if [ $battery_status ]; then
    if [ $battery_status = "charging" ]; then
        output+="^ $battery_charge | "
    else
        output+="v $battery_charge | "
    fi
fi

# Date time

output+=$(date "+%d-%m-%Y %H:%M")

# Output

echo $output