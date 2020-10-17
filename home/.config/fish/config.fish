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
#                 └─ https://github.com/NNBnh


# Plugins
if not functions -q fisher
    set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
    curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
    fish -c fisher
end

# Prompt
command -q starship ; or curl -fsSL https://starship.rs/install.sh | sh
starship init fish | source
