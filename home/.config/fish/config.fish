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
source $HOME/.config/env


# Functions
if not type -q 'starship'
    curl -fsSL https://starship.rs/install.sh --create-dirs -o $XDG_CACHE_HOME/starship-installer
    chmod +x $XDG_CACHE_HOME/starship-installer
    eval "$XDG_CACHE_HOME/starship-installer --yes --bin-dir '$HOME/.local/bin'"
end


# Start
starship init fish | source
