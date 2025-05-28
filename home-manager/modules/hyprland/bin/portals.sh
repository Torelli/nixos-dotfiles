#!/bin/sh
sleep 1

systemctl --user stop xdg-desktop-portal
systemctl --user stop xdg-desktop-portal-gtk
systemctl --user stop xdg-desktop-portal-hyprland

systemctl --user start xdg-desktop-portal-hyprland
systemctl --user start xdg-desktop-portal-gtk
systemctl --user start xdg-desktop-portal
