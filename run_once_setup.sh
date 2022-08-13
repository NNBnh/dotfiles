#!/bin/sh

sudo pacman --sync --sysupgrade --refresh --needed git base-devel
git clone https://aur.archlinux.org/paru-bin.git ~/.cache/paru
cd ~/.cache/paru
makepkg --syncdeps --install --noconfirm

paru --sync --skipreview --useask --noconfirm --needed flatpak chezmoi ruby ruby-rdoc ruby-docs xonsh neovim btop trash-cli p7zip git ffmpeg

flatpak install flathub com.nextcloud.desktopclient.nextcloud org.contourterminal.Contour org.mozilla.firefox com.usebottles.bottles org.blender.Blender org.godotengine.Godot com.valvesoftware.Steam org.libretro.RetroArch org.polymc.PolyMC sh.ppy.osu

chsh -s $(which xonsh)

sudo systemctl enable gdm.service
sudo systemctl enable bluetooth.service

echo '
GTK_IM_MODULE=ibus
QT_IM_MODULE=ibus
XMODIFIERS=@im=ibus
GLFW_IM_MODULE=ibus
' | sudo tee --append /etc/environment > /dev/null

systemctl reboot
