#!/bin/sh
#
# network-config.sh — toggle Impala WiFi manager

title="Bluetui"

is_hypr() {
    [ -n "$HYPRLAND_INSTANCE_SIGNATURE" ] && command -v hyprctl >/dev/null 2>&1
}

is_niri() {
    command -v niri >/dev/null 2>&1
}

if pgrep -x impala >/dev/null; then
    if is_hypr; then
        addr=$(hyprctl clients -j | jq -r ".[] | select(.title==\"$title\") | .address")
        ws=$(hyprctl activeworkspace -j | jq -r '.id')
        [ -n "$addr" ] && hyprctl dispatch movetoworkspace "$ws",address:"$addr"
        hyprctl dispatch focuswindow title:$title
    elif is_niri; then
        id=$(niri msg -j windows | jq -r ".[] | select(.title==\"$title\") | .id")
        if [ -n "$id" ]; then
            current_ws=$(niri msg workspaces | grep '\*' | awk '{print $2}')
	    niri msg action move-window-to-workspace --window-id "$id" --focus true "$current_ws" 

        fi
    else
        echo "No supported compositor detected."
    fi
    exit 0
fi

# If not running → start it
foot --title "$title" -e bluetui

