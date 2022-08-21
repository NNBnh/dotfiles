#!/bin/sh

sudo dnf copr enable --assumeyes peterwu/iosevka
sudo dnf install --assumeyes \
	papirus-icon-theme iosevka-curly-fonts ibus-unikey \
	ruby xonsh neovim trash-cli p7zip ffmpeg-free

sudo dnf remove --assumeyes gnome-terminal firefox
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install --assumeyes flathub \
	org.wezfurlong.wezterm org.mozilla.firefox com.usebottles.bottles \
	org.blender.Blender org.godotengine.Godot \
	com.valvesoftware.Steam org.libretro.RetroArch org.polymc.PolyMC sh.ppy.osu

chsh -s $(which xonsh)

git config --global user.email nnbnh@protonmail.com
git config --global user.name NNB
git config --global credential.helper store
