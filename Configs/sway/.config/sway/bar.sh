# Sway bar script

# Date time

date_time=$(date "+%d-%m-%Y %H:%M")

# Media

media_status=$(playerctl status)
media_artist=$(playerctl metadata artist)
media_title=$(playerctl metadata title)

if [ $media_status = "Playing" ]; then
    media="> $media_artist - $media_title"
elif [ "$media_status" = "Paused" ]; then
    media="# $media_artist - $media_title"
else
    media="? The voices - Ego"
fi

# Battery

battery_charge=$(upower --show-info $(upower --enumerate | grep 'BAT') | egrep "percentage" | awk '{print $2}')
battery_status=$(upower --show-info $(upower --enumerate | grep 'BAT') | egrep "state" | awk '{print $2}')

if [ $battery_status = "charging" ]; then
    battery="^ $battery_charge"
else
    battery="v $battery_charge"
fi

# Output

echo "$media | $battery | $date_time "