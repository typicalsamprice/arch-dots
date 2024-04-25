#!/usr/bin/bash

set -eou pipefail
set -x

base=$(pwd)

USE_KDE=false

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
	if ! test -d "${XDG_CONFIG_HOME:-$HOME/.config}/$folder"; then
		ln -sf "$(pwd)/$folder" "${XDG_CONFIG_HOME:-$HOME/.config}/$folder"
	fi
done

cd "$base"

### INSTALL PACKAGES ###
sudo pacman -Syyu

# Install yay / build deps
sudo pacman -S --needed --noconfirm base-devel git pacman-contrib

if ! test -f /usr/bin/yay; then
	git clone https://aur.archlinux.org/yay.git /tmp/yay
	cd /tmp/yay
	makepkg -si
	cd "$base"
fi

## Utils
yay -S --needed --noconfirm ripgrep fd cloc
yay -S --needed --noconfirm unrar unzip zip xz gzip
yay -S --needed --noconfirm wget curl
yay -S --needed --noconfirm eza

yay -S --needed --noconfirm zathura zathura-pdf-poppler

## Terminals
# Alacritty works w/ both X and Wayland
yay -S --needed --noconfirm alacritty

## Editors, prog-related
yay -S --needed --noconfirm emacs neovim

if ! test -f /usr/bin/vi; then
	sudo ln -s /usr/bin/nvim /usr/bin/vi
fi
if ! test -f /usr/bin/vim; then
	sudo ln -s /usr/bin/nvim /usr/bin/vim
fi

### Languages/Scripting
yay -S --needed --noconfirm gcc clang llvm
yay -S --needed --noconfirm cmake
yay -S --needed --noconfirm rstudio-desktop-bin

yay -S --needed --noconfirm texlive

#### Rust
yay -S --needed --noconfirm rustup
rustup default stable
rustup component add rust-analyzer

## System Tools
yay -S --needed --noconfirm networkmanager
yay -S --needed --noconfirm pavucontrol
yay -S --needed --noconfirm inetutils
yay -S --needed --noconfirm bluez bluez-utils

## Microcode updates
yay -S --needed --noconfirm amd-ucode intel-ucode

## Apps
yay -S --needed --noconfirm firefox
yay -S --needed --noconfirm flameshot mpv
yay -S --needed --noconfirm obs-studio

if NOT_KDE; then
	yay -S --needed --noconfirm pcmanfm
	yay -S --needed --noconfirm network-manager-applet
fi

## Fonts
yay -S --needed --noconfirm nerd-fonts
yay -S --needed --noconfirm ttf-monaco-nerd-font-git

## WMs
# X
yay -S --needed --noconfirm awesome
yay -S --needed --noconfirm sxiv

# Wayland
## Hyprland
yay -S --needed --noconfirm hyprland hypridle hyprcursor
yay -S --needed --noconfirm xdg-desktop-portal-hyprland

## General Wayland
yay -S --needed --noconfirm swaybg swaync
yay -S --needed --noconfirm waybar waylock
yay -S --needed --noconfirm wlogout wlsunset
yay -S --needed --noconfirm imv
yay -S --needed --noconfirm hyprpicker
