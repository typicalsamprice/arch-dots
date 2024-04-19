#!/usr/bin/bash

set -eou pipefail
set -x

base=$(pwd)

### LINK LIBINPUT CONF FILES ###
cd libinput

for libconf in ./*; do
	sudo ln -sf "$(pwd)/$libconf" "/etc/X11/xorg.conf.d/$libconf"
done

cd "$base"

### LINK HOME-DIR DOTFILES ###
cd homedir-dots

for dotf in $(ls -A1); do
	ln -sf "$(pwd)/$dotf" "$HOME/$dotf"
done

cd "$base"

### GO THROUGH CONFIG FOLDER ###
cd config-folder-dots

for folder in $(ls -A1); do
	ln -sf "$(pwd)/$folder"
done

cd "$base"

### INSTALL PACKAGES ###
sudo pacman -Syyu

# Install yay / build deps
sudo pacman -S --needed base-devel git pacman-contrib

git clone https://aur.archlinux.org/yay.git /tmp/yay
cd /tmp/yay
makepkg -si

cd "$base"

## Utils
yay -S ripgrep fd cloc
yay -S unrar unzip zip xz gzip
yay -S wget curl
yay -S eza

yay -S zathura zathura-pdf-poppler

## Terminals
# Alacritty works w/ both X and Wayland
yay -S alacritty

## Editors, prog-related
yay -S emacs neovim

sudo ln -s /usr/bin/nvim /usr/bin/vi
sudo ln -s /usr/bin/nvim /usr/bin/vim

### Languages/Scripting
yay -S gcc clang llvm
yay -S texlive
yay -S rstudio-desktop-bin

#### Rust
yay -S rustup
rustup default stable
rustup component add rust-analyzer

## System Tools
yay -S networkmanager
yay -S pavucontrol
yay -S inetutils
yay -S bluez bluez-utils

## Microcode updates
yay -S amd-ucode intel-ucode

## Apps
yay -S firefox
yay -S network-manager-applet
yay -S flameshot mpv
yay -S pcmanfm
yay -S obs-studio

## Fonts
yay -S nerd-fonts
yay -S ttf-monaco-nerd-font-git

## WMs
# X
yay -S awesome
yay -S sxiv

# Wayland
## Hyprland
yay -S hyprland hypridle hyprcursor
yay -S xdg-desktop-portal-hyprland

## General Wayland
yay -S swaybg swaync
yay -S waybar waylock
yay -S wlogout wlsunset
yay -S imv
yay -S hyprpicker
