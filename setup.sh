#!/bin/sh

sudo dnf copr enable --assumeyes peterwu/iosevka
sudo dnf install --assumeyes papirus-icon-theme iosevka-curly-fonts ibus-unikey
sudo dnf remove --assumeyes gnome-terminal

gsettings set org.gnome.desktop.interface icon-theme Papirus
bash -c "$(curl -fsSL https://raw.githubusercontent.com/rafaelmardojai/firefox-gnome-theme/master/scripts/install-by-curl.sh)"


flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install --assumeyes flathub \
	org.wezfurlong.wezterm com.usebottles.bottles org.js.nuclear.Nuclear \
	com.visualstudio.code org.blender.Blender org.godotengine.Godot \
	com.valvesoftware.Steam org.libretro.RetroArch org.polymc.PolyMC sh.ppy.osu

mkdir -p ~/.var/app/org.wezfurlong.wezterm/config/wezterm
cat > ~/.var/app/org.wezfurlong.wezterm/config/wezterm/wezterm.lua << CONFIG
local wezterm = require 'wezterm'

return {
  font = wezterm.font 'Iosevka Curly Extended',
  font_size = 10.0,
  color_scheme = 'Catppuccin Mocha',
  bold_brightens_ansi_colors = false,
  use_fancy_tab_bar = false,
  hide_tab_bar_if_only_one_tab = true,
  keys = {
    { key =    'UpArrow', mods = 'CTRL|SHIFT', action = 'DisableDefaultAssignment' },
    { key =  'DownArrow', mods = 'CTRL|SHIFT', action = 'DisableDefaultAssignment' },
    { key =  'LeftArrow', mods = 'CTRL|SHIFT', action = 'DisableDefaultAssignment' },
    { key = 'RightArrow', mods = 'CTRL|SHIFT', action = 'DisableDefaultAssignment' },
    { key =          'Z', mods = 'CTRL|SHIFT', action = wezterm.action.SendKey { key = 'Y',     mods = 'CTRL' } },
    { key =      'Enter', mods =      'SHIFT', action = wezterm.action.SendKey { key = 'Enter', mods = 'ALT'  } },
  },
  default_prog = {'/home/linuxbrew/.linuxbrew/bin/nu'},
}
CONFIG


bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
brew install ruby nushell micro p7zip ffmpeg imagemagick gifski asciinema

git config --global user.email nnbnh@protonmail.com
git config --global user.name NNB
git config --global credential.helper store
git config --global pull.rebase true

# TODO nushell

mkdir -p ~/.config/micro
cat > ~/.config/micro/settings.json << CONFIG
{
    "colorscheme": "geany",
    "mkparents": true,
    "rmtrailingws": true
}
CONFIG
