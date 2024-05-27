#!/bin/sh
get_icon() {
    case $1 in
        # Icons for weather-icons
        01d) icon="";;
        01n) icon="";;
        02d) icon="";;
        02n) icon="";;
        03*) icon="";;
        04*) icon="";;
        09d) icon="";;
        09n) icon="";;
        10d) icon="";;
        10n) icon="";;
        11d) icon="";;
        11n) icon="";;
        13d) icon="";;
        13n) icon="";;
        50d) icon="";;
        50n) icon="";;
        sunrise) icon="";;
        sunset) icon="";;
        down) icon="";;
        up) icon="";;
        neutral) icon="";;
        *) icon="";
    esac

    echo "<span font_family='Weather Icons'>$icon</span>"
}

format_time() {

    osname=$(uname -s)

    case $osname in
        *BSD) date -r "$1" "+%l:%M %p";;
        *) date --date="@$1" "+%l:%M %p";;
    esac

}

KEY="bd5e378503939ddaee76f12ad7a97608" # not a secret: https://gist.github.com/c8f973dc6754384d6cade282b64a8cb1
UNITS="imperial"
SYMBOL="°"

API="https://api.openweathermap.org/data/2.5"

location=$(curl -sf https://location.services.mozilla.com/v1/geolocate?key=geoclue)

if [ -n "$location" ]; then
    location_lat="$(echo "$location" | jq '.location.lat')"
    location_lon="$(echo "$location" | jq '.location.lng')"

    current=$(curl -sf "$API/weather?appid=$KEY&lat=$location_lat&lon=$location_lon&units=$UNITS")
    forecast=$(curl -sf "$API/forecast?appid=$KEY&lat=$location_lat&lon=$location_lon&units=$UNITS&cnt=1")
fi

if [ -n "$current" ] && [ -n "$forecast" ]; then
    current_temp=$(echo "$current" | jq ".main.temp" | cut -d "." -f 1)
    current_icon=$(echo "$current" | jq -r ".weather[0].icon")

    forecast_temp=$(echo "$forecast" | jq ".list[].main.temp" | cut -d "." -f 1)
    forecast_icon=$(echo "$forecast" | jq -r ".list[].weather[0].icon")


    if [ "$current_temp" -gt "$forecast_temp" ]; then
        trend=$(get_icon "down")
    elif [ "$forecast_temp" -gt "$current_temp" ]; then
        trend=$(get_icon "up")
    else
        trend=$(get_icon "neutral")
    fi


    sun_rise=$(echo "$current" | jq ".sys.sunrise")
    sun_set=$(echo "$current" | jq ".sys.sunset")
    now=$(date +%s)
    
    
    if [ "$sun_rise" -gt "$now" ]; then
        daytime="$(get_icon "sunrise")$(format_time "$sun_rise")"
    elif [ "$sun_set" -gt "$now" ]; then
        daytime="$(get_icon "sunset")$(format_time "$sun_set")"
    else
        daytime="$(get_icon "sunrise")$(format_time "$sun_rise")"
    fi


    echo "$(get_icon "$current_icon") $current_temp$SYMBOL $trend $(get_icon "$forecast_icon") $forecast_temp$SYMBOL $daytime"
fi
