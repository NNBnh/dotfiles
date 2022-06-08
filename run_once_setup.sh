#!/bin/sh

# TODO bmono
sudo paru --sync --skipreview --useask --noconfirm --needed \
	nextcloud-client ibus-unikey ttf-sarasa-gothic \
	kitty librewolf-bin blender godot \
	steam retroarch multimc-bin osu-lazer-bin \
	ruby xonsh neovim \
	btop trash-cli p7zip ffmpeg git

chsh -s $(which xonsh)
