#!/bin/sh

# Source the colors from wal
source "${HOME}/.cache/wal/colors.sh"
source "${HOME}/.cache/wal/colors-tty.sh"

# =================================================
# Symlink config files so programs can be started
# without referencing the cache directly
#
# Includes: zathura, dunst
# =================================================

mkdir -p  "${HOME}/.config/zathura"
mkdir -p  "${HOME}/.config/dunst"
ln -sf    "${HOME}/.cache/wal/zathurarc"  "${HOME}/.config/zathura/zathurarc"
ln -sf    "${HOME}/.cache/wal/dunstrc"    "${HOME}/.config/dunst/dunstrc"
ln -sf    "${HOME}/.cache/wal/colors"    "${HOME}/.config/vis/colors/pywal"

# ===================
# ====== dunst ======
# ===================

# Restart dunst with the new color scheme
pkill dunst
dunst -config ~/.config/dunst/dunstrc &
notify-send "PyWall" "Theme changed, enjoy!" &

