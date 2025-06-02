#!/usr/bin/fish

set wallpaper $argv[1]

set brightness (magick "$wallpaper" -colorspace Gray -format "%[fx:mean]" info:)

set threshold 0.7

if test (math "$brightness - $threshold") -gt 0
    matugen image "$wallpaper" -m light
    gsettings set org.gnome.desktop.interface color-scheme prefer-light
    set theme "Light Theme"
else
    matugen image "$wallpaper"
    gsettings set org.gnome.desktop.interface color-scheme prefer-dark
    set theme "Dark Theme"
end

notify-send Theme has been changed "Current theme: $theme" --icon="$HOME/.config/waypaper/scripts/icon.svg"
