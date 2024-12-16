#!/bin/bash

set -eu

GTK_THEME="Materia-light"
ICON_THEME="Numix-Circle"
FONT_NAME="UbuntuSans NFP Medium"

if ! which gsettings &> /dev/null; then
    echo "gsettings must be installed"
    exit 1
fi

if [[ ! -d "/usr/share/themes/${GTK_THEME}" ]]; then
    echo "${GTK_THEME} not installed"
    exit 1
fi

if [[ ! -d "/usr/share/icons/${ICON_THEME}" ]]; then
    echo "${ICON_THEME} not installed"
    exit 1
fi

if [[ $(fc-list | grep -c "$FONT_NAME") == 0 ]]; then
    echo "${FONT_NAME} is not installed"
    exit 1
fi

gsettings set org.gnome.desktop.interface gtk-theme "$GTK_THEME"
echo "GTK Theme: $(gsettings get org.gnome.desktop.interface gtk-theme)"

gsettings set org.gnome.desktop.interface icon-theme "$ICON_THEME"
echo "Icon theme: $(gsettings get org.gnome.desktop.interface icon-theme)"

gsettings set org.gnome.desktop.interface font-name "$FONT_NAME"
echo "Font name: $(gsettings get org.gnome.desktop.interface font-name)"
