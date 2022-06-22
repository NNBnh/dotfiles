#!/bin/sh

paru --sync --skipreview --useask --noconfirm --needed \
	chezmoi nextcloud-client \
	ibus-unikey ttf-bmono ttf-sarasa-gothic \
	kitty librewolf-bin blender godot \
	steam multimc-bin osu-lazer-bin \
	retroarch retroarch-assets-ozone \
		libretro-mesen libretro-bsnes libretro-mupen64plus-next libretro-dolphin \
		libretro-duckstation libretro-pcsx2 \
		libretro-sameboy libretro-mgba libretro-desmume libretro-citra \
	ruby xonsh neovim trash-cli p7zip ffmpeg git

chsh -s $(which xonsh)
