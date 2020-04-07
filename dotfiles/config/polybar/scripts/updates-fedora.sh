#!/bin/sh

BAR_ICON=""

get_total_updates() {
	dnf=$(env LC_ALL=C dnf check-update 2> /dev/null)
	UPDATES=$(echo "$dnf" | grep -E '[^@]updates' | wc -l)
}


while true; do
    get_total_updates

    # notify user of updates
    if (( UPDATES > 50 )); then
        notify-send -u critical "You really need to update!!" "$UPDATES New packages"
    elif (( UPDATES > 25 )); then
        notify-send -u normal "You should update soon" "$UPDATES New packages"
    elif (( UPDATES > 2 )); then
        notify-send -u low "$UPDATES New packages to update"
    fi

    # when there are updates available
    # every 10 seconds another check for updates is done
    if (( UPDATES > 0 )); then
        echo "$BAR_ICON $UPDATES"
    else
        echo $BAR_ICON
    fi

    sleep 1800
done