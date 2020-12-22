#!/bin/fish

# __   __      __
# \ \  \ \    |  \
#  \ \  \ \   |  /
#   \ \  \ \  |   \
#    \_\  \_\ |___/
#

# File:         config.fish
# Description:  Fish config that SuperB
# Author:       NNB
#               └─ https://github.com/NNBnh
# URL:          https://github.com/NNBnh/dots/blob/master/home/.config/fish/config.fish


# Values
source "$HOME/.config/env"
set --global fish_prompt_pwd_dir_length '16'

# Functions
if not type -q 'starship'
    curl -fsSL https://starship.rs/install.sh --create-dirs -o "$TMPDIR/starship-installer"
    chmod +x "$TMPDIR/starship-installer"
    eval "$TMPDIR/starship-installer --yes --bin-dir '$HOME/.local/bin'"
end


# Start
starship init fish | source
