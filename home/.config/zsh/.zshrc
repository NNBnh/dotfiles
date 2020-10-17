# __   __      __
# \ \  \ \    |  \
#  \ \  \ \   |  /
#   \ \  \ \  |   \
#    \_\  \_\ |___/
#

# File:         .zshrc
# Description:  Zshrc config that SuperB
# Author:       NNB
#                 └─ https://github.com/NNBnh

	# Bfecth
	export BF_prompt_height="3"
	export BF_info0="$(tput bold)$(tput setaf 11)OS:        $(tput sgr0) Arch Linux"
	export BF_info1="$(tput bold)$(tput setaf 11)WM:        $(tput sgr0)舘Bspwm"
	export BF_info2="$(tput bold)$(tput setaf 11)SHELL:     $(tput sgr0) Zsh"
	export BF_info3="$(tput bold)$(tput setaf 11)TERMINAL:  $(tput sgr0) Alacritty"
	export BF_info4="$(tput bold)$(tput setaf 11)FONT:      $(tput sgr0) JetBrains Mono"
	export BF_info_size="27"
	export BF_pic="$HOME/.local/share/fetchs/unicode/gamebtw"

	fish

	command -q starship && curl -fsSL https://starship.rs/install.sh | sh
	eval "$(starship init zsh)"
