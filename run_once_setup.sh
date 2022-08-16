#!/bin/sh

sudo dnf install --assumeyes flatpak ruby xonsh neovim btop trash-cli p7zip git ffmpeg

flatpak install flathub org.wezfurlong.wezterm org.mozilla.firefox com.usebottles.bottles org.blender.Blender org.godotengine.Godot com.valvesoftware.Steam org.libretro.RetroArch org.polymc.PolyMC sh.ppy.osu

chsh -s $(which xonsh)
