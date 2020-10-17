#!/bin/sh


# Package's list
install_windows_manager='grub lightdm bspwm ufw sxhkd nitrogen picom dunst libnotify conky papirus-icon-theme ttf-jetbrains-mono adobe-source-han-sans-jp-fonts languagetool'
install_a_windows_manager='polybar betterlockscreen ibus-bamboo xf86-input-wizardpen'

install_command_line_softwares='zsh fzf fd python nim pass maim imagemagick redshift mopidy xorg-xbacklight pulseaudio pamixer xorg-xmodmap xorg-setxkbmap xorg-xev xclip surfraw translate-shell task timew lolcat'
install_a_command_line_softwares='toilet pixterm-git no-more-secrets'
install_files_transporter='stow git wget curl rsync rtorrent youtube-dl'
install_a_files_transporter='ffsend-bin'

install_tui_softwares='fff neovim glances weechat pulsemixer ncmpcpp'
install_a_tui_softwares='unimatrix-git'
install_gui_softwares='alacritty kitty rofi rofi-pass rofimoji nemo firefox pix mpv gimp blender audacity lmms onlyoffice-bin zathura zathura-pdf-poppler zathura-cb'
install_a_gui_softwares='rofication-git rofi-greenclip rofi-wifi-menu-git rofi-file-browser-extended-git rofi-calc rofi-mpc godot-bin'
install_games='steam lutris retroarch'
install_a_games='minecraft-launcher flips'


# Install repository's packages
if  [[ $1 = "-u" ]]; then
	yay -S $install_a_windows_manager $install_a_gui_softwares $install_a_files_transporter $install_a_tui_softwares $install_a_games
else
	sudo pacman -Syu --noconfirm $install_windows_manager $install_command_line_softwares $install_files_transporter $install_tui_softwares $install_gui_softwares $install_games

	git clone https://aur.archlinux.org/yay.git "$HOME/.local/share/yay"
	cd "$HOME/.local/share/yay"
	makepkg -si


	# Install more packages
		# Dotfiles
		git clone https://github.com/SakashiNNB/Dotfiles.git "$HOME/Dotfiles/Cloud"

		# Grub theme
		git clone https://github.com/mateosss/matter.git "$HOME/.local/share/grub/themes/matter"

		# Fonts
		mkdir -p "$HOME/.local/share/fonts"
		cd "$HOME/.local/share/fonts"
		curl \
			-o "JetBrains Mono Regular Nerd Font Complete.ttf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/JetBrainsMono/Regular/complete/JetBrains%20Mono%20Regular%20Nerd%20Font%20Complete.ttf \
			-O https://github.com/antijingoist/opendyslexic/raw/master/compiled/OpenDyslexic-Regular.otf \
			-O https://github.com/vernnobile/PacificoFont/raw/master/2.0/sources/Pacifico-Regular.otf \
			-O https://github.com/vernnobile/MaticFonts/raw/master/Amatic/version-2.0/Regular/Amatic.ttf \
			-O https://github.com/googlefonts/comfortaa/raw/master/fonts/OTF/Comfortaa-Regular.otf \
			-O https://github.com/impallari/The-Lobster-Font/raw/master/fonts/otf/Lobster-Regular.otf \
			-O https://github.com/m4rc1e/PatrickHandSC/raw/master/fonts/PatrickHandSC-Regular.ttf \
			-O https://github.com/cadsondemak/Mali/raw/master/fonts/Mali-Regular.ttf \
			-O https://github.com/theleagueof/fanwood/raw/master/Fanwood.otf \
			-o "Fanwood-Italic.otf" https://github.com/theleagueof/fanwood/raw/master/Fanwood%20Italic.otf \
			-o "Fanwood-Text.otf" https://github.com/theleagueof/fanwood/raw/master/Fanwood%20Text.otf \
			-o "Fanwood-Text-Italic.otf" https://github.com/theleagueof/fanwood/raw/master/Fanwood%20Text%20Italic.otf \
			-o "Raleway-Thin.otf" https://github.com/theleagueof/raleway/raw/master/Raleway%20Thin.otf \
			-O https://github.com/theleagueof/league-script-number-one/raw/master/LeagueScriptNumberOne.otf \
			-O https://github.com/theleagueof/ostrich-sans/raw/master/OstrichSans-Light.otf \
			-O https://github.com/theleagueof/ostrich-sans/raw/master/OstrichSans-Medium.otf \
			-O https://github.com/theleagueof/ostrich-sans/raw/master/OstrichSans-Bold.otf \
			-O https://github.com/theleagueof/ostrich-sans/raw/master/OstrichSans-Heavy.otf \
			-O https://github.com/theleagueof/ostrich-sans/raw/master/OstrichSans-Black.otf \
			-O https://github.com/theleagueof/ostrich-sans/raw/master/OstrichSansInline-Regular.otf \
			-O https://github.com/theleagueof/ostrich-sans/raw/master/OstrichSansInline-Italic.otf \
			-O https://github.com/theleagueof/ostrich-sans/raw/master/OstrichSansRounded-Medium.otf \
			-O https://github.com/theleagueof/ostrich-sans/raw/master/OstrichSansDashed-Medium.otf \
			-O https://github.com/theleagueof/chunk/raw/master/ChunkFive-Regular.otf \
			-o "Chunk-Five-Print.otf" https://github.com/theleagueof/chunk/raw/master/Chunk%20Five%20Print.otf \
			-o "Sniglet-Regular.otf" https://github.com/theleagueof/sniglet/raw/master/Sniglet%20Regular.otf \
			-O https://github.com/theleagueof/knewave/raw/master/knewave.otf \
			-O https://github.com/theleagueof/knewave/raw/master/knewave-outline.otf \
			-O https://github.com/uplaod/Nemoy/raw/master/fonts/Nemoy-Light.otf \
			-O https://github.com/uplaod/Nemoy/raw/master/fonts/Nemoy-Medium.otf \
			-O https://github.com/uplaod/Nemoy/raw/master/fonts/Nemoy-Bold.otf \
			-O https://github.com/figs-lab/datalegreya/raw/master/font-files/Datalegreya-Dot.otf \
			-O https://github.com/figs-lab/datalegreya/raw/master/font-files/Datalegreya-Gradient.otf \
			-O https://github.com/figs-lab/datalegreya/raw/master/font-files/Datalegreya-Thin.otf \
			-O https://gitlab.com/velvetyne/Avara/raw/master/fonts/Avara-Bold.otf \
			-O https://gitlab.com/velvetyne/Avara/raw/master/fonts/Avara-BoldItalic.otf \
			-O https://gitlab.com/velvetyne/Avara/raw/master/fonts/Avara-Black.otf \
			-O http://pecita.eu/b/Pecita.otf
			-O https://github.com/kyoyababa/font-FriendsFu/raw/master/resources/FriendsFu.otf

		# Bspwm plugins
		git clone https://github.com/BrodieRobertson/cleanfullscreen.git "$HOME/.local/share/bspwm/plugins/cleanfullscreen"

		# Zsh plugins
		git clone https://github.com/romkatv/powerlevel10k "$HOME/.local/share/zsh/plugins/powerlevel10k"
		git clone https://github.com/desyncr/fast-syntax-highlighting.git "$HOME/.local/share/zsh/plugins/fast-syntax-highlighting"
		curl -fLo "$HOME/.local/share/zsh/plugins/git.plugin.zsh" --create-dirs https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/plugins/git/git.plugin.zsh
		curl -fLo "$HOME/.local/share/zsh/plugins/archlinux.plugin.zsh" --create-dirs https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/plugins/archlinux/archlinux.plugin.zsh
		sed -i '/compdef/d' "$HOME/.local/share/zsh/plugins/git.plugin.zsh"

		# Neovim Plugins
		python3 -m pip install --user --upgrade pynvim
		curl -fLo "$HOME/.local/share/nvim/site/autoload/plug.vim" --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim


	# Config
		# Enable Dotfiles
		mkdir "$HOME/.config/retroarch"
		cd "$HOME/Dotfiles/Cloud/Dotfiles"
		stow -vt ~ *
		ln -sf ~/Dotfiles/Cloud/Dotfiles/Gtk/.local/share/themes ~/.themes

		# Making Zsh to default shell
		chsh -s "/usr/bin/zsh"

		# Enable firewall
		sudo ufw enable

		# Add tablet config
		sudo ln -sf "$HOME/Dotfiles/Cloud/Rootfiles/52-tablet.conf" "/etc/X11/xorg.conf.d/52-tablet.conf"

fi
