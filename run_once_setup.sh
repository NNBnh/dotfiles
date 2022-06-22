#!/bin/sh

sudo pacman --sync --sysupgrade --refresh --needed git base-devel
git clone https://aur.archlinux.org/paru-bin.git ~/.cache/paru
cd ~/.cache/paru
makepkg --syncdeps --install --noconfirm

paru --sync --skipreview --useask --noconfirm --needed \
	chezmoi nextcloud-client \
	gnome ibus-unikey ttf-bmono ttf-sarasa-gothic \
	kitty firefox blender godot \
	steam multimc-bin osu-lazer-bin \
	retroarch retroarch-assets-ozone \
		libretro-mesen libretro-bsnes libretro-mupen64plus-next libretro-dolphin \
		libretro-duckstation libretro-pcsx2 \
		libretro-sameboy libretro-mgba libretro-desmume libretro-citra \
	ruby xonsh neovim nvimpager trash-cli p7zip ffmpeg git

for user_directories in DOCUMENTS PICTURES VIDEOS MUSIC DESKTOP DOWNLOAD PUBLICSHARE TEMPLATES; do
	xdg-user-dirs-update --set $user_directories ~
done

chsh -s $(which xonsh)

sudo systemctl enable gdm.service
sudo systemctl enable bluetooth.service

echo "GTK_IM_MODULE=ibus\nQT_IM_MODULE=ibus\nXMODIFIERS=@im=ibus\nGLFW_IM_MODULE=ibus" | sudo tee --append /etc/environment > /dev/null

systemctl reboot
