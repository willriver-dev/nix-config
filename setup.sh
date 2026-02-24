#!/usr/bin/env bash
# setup.sh — Copy dotfiles config/ → ~/.config/ và init DMS include files cho niri

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_SRC="$SCRIPT_DIR/config"
CONFIG_DST="$HOME/.config"

# DMS niri include files phải tồn tại trước khi niri load config
mkdir -p "${CONFIG_DST}/niri/dms"
touch "${CONFIG_DST}/niri/dms/colors.kdl" \
      "${CONFIG_DST}/niri/dms/layout.kdl" \
      "${CONFIG_DST}/niri/dms/alttab.kdl" \
      "${CONFIG_DST}/niri/dms/binds.kdl"

cp -r "${CONFIG_SRC}/." "${CONFIG_DST}/"

echo "Done. Log out hoặc restart niri để áp dụng."

