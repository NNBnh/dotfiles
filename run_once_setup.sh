#!/bin/sh

sudo dnf install --assumeyes papirus-icon-theme ibus-unikey ruby xonsh neovim trash-cli p7zip ffmpeg-free

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install --assumeyes flathub \
	org.wezfurlong.wezterm org.mozilla.firefox com.usebottles.bottles \
	org.blender.Blender org.godotengine.Godot \
	com.valvesoftware.Steam org.libretro.RetroArch org.polymc.PolyMC sh.ppy.osu

chsh -s $(which xonsh)

git config --global user.email nnbnh@protonmail.com
git config --global user.name NNB
git config --global credential.helper store
