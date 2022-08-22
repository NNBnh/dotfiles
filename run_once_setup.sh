#!/bin/sh

sudo dnf copr enable --assumeyes peterwu/iosevka
sudo dnf install --assumeyes papirus-icon-theme iosevka-curly-fonts ibus-unikey

gsettings set org.gnome.desktop.interface icon-theme 'Papirus'

sudo dnf remove --assumeyes gnome-terminal
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install --assumeyes flathub \
	org.wezfurlong.wezterm com.usebottles.bottles \
	com.visualstudio.code org.blender.Blender org.godotengine.Godot \
	com.valvesoftware.Steam org.libretro.RetroArch org.polymc.PolyMC sh.ppy.osu

bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
brew install ruby nushell micro p7zip ffmpeg imagemagick gifski

git config --global user.email nnbnh@protonmail.com
git config --global user.name NNB
git config --global credential.helper store
