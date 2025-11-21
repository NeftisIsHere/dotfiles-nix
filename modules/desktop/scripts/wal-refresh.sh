#!/bin/bash
# Minimal Waypaper → Pywal hook

WALLPAPER="$1"

# Apply pywal colors
# wal -q -i "$WALLPAPER" --backend wal
# wal -q -i "$WALLPAPER" --backend modern_colorthief
wal -q -i "$WALLPAPER" --backend colorz
cp $XDG_CACHE_HOME/wal/niri/niri-colors $dotconf/niri/colors.kdl

cp $XDG_CACHE_HOME/wal/rmpc/pywal16.ron $dotconf/rmpc/themes/pywal16.ron

cp "${HOME}"/.cache/wal/pywal.kvconfig "${HOME}"/.config/Kvantum/pywal/pywal.kvconfig

cp "${HOME}"/.cache/wal/pywal.svg "${HOME}"/.config/Kvantum/pywal/pywal.svg

systemctl --user restart swaync || { 
  pkill swaync && while pgrep swaync >/dev/null; do sleep 0.1; done && swaync & 
}

walcord

