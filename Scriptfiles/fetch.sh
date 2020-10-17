#!/bin/sh

cat <<EOF

$(tput sgr0)$(tput setaf 8)     ┌───┐     $(tput sgr0)$(tput bold)$(tput setaf 11)OS:        $(tput sgr0) Arch Linux$(tput sgr0)
$(tput sgr0)$(tput setaf 8)     │$(tput setab 8)$(tput setaf 11)▐█▌$(tput sgr0)$(tput setaf 8)│     $(tput sgr0)$(tput bold)$(tput setaf 11)WM:        $(tput sgr0)舘Bspwm$(tput sgr0)
$(tput sgr0)$(tput setaf 8)     │$(tput bold)+ $(tput setaf 9)⠔$(tput setaf 8)│     $(tput sgr0)$(tput bold)$(tput setaf 11)SHELL:     $(tput sgr0) Zsh$(tput sgr0)
$(tput sgr0)$(tput setaf 8)     └───'     $(tput sgr0)$(tput bold)$(tput setaf 11)TERMINAL:  $(tput sgr0) Alacritty$(tput sgr0)
$(tput sgr0)$(tput bold)$(tput setaf 11)    GameBtw    $(tput sgr0)$(tput bold)$(tput setaf 11)FONT:      $(tput sgr0) JetBrains Mono$(tput sgr0)

$(tput sgr0)     $(tput setab 0)    $(tput setab 1)    $(tput setab 2)    $(tput setab 3)    $(tput setab 4)    $(tput setab 5)    $(tput setab 6)    $(tput setab 7)    $(tput sgr0)
$(tput sgr0)     $(tput setab 8)    $(tput setab 9)    $(tput setab 10)    $(tput setab 11)    $(tput setab 12)    $(tput setab 13)    $(tput setab 14)    $(tput setab 15)    $(tput sgr0)

EOF

exit
