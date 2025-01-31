#!/bin/bash
set -e

if ! command -v stow 2>&1 >/dev/null 
then
    echo "Stow is not installed."
    echo "Please install it using 'sudo pacman -Sy stow'"
    exit -1
fi

stow fontconfig
stow profile-picture
stow dunst
stow fish
stow gtk
stow fontconfig
stow wayland-hyprland
stow --adopt desktop-kde
stow custom-scripts
stow git
stow env
