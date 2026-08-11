#!/usr/bin/env bash

# Options ------------------------------------------------------------------------------------------

shopt -s autocd dotglob globstar nullglob

[[ -f /home/linuxbrew/.linuxbrew/lib/bash/flyline ]] && enable -f /home/linuxbrew/.linuxbrew/lib/bash/flyline flyline
[[ -f ~/.linuxbrew/lib/bash/flyline ]] && enable -f ~/.linuxbrew/lib/bash/flyline flyline
[[ -f ~/.local/lib/libflyline.so ]] && enable -f ~/.local/lib/libflyline.so flyline
command -v flyline >/dev/null && {
    flyline set-cursor --backend terminal --interpolate none
    flyline suggestions --sort-order alphabetical
    flyline key bind Ctrl+a "always=selectAll"
    flyline key bind Right "bufferIsEmpty=insertString(cd )"
    flyline key bind Alt+Left "bufferIsEmpty=insertString(prevd)+submitOrNewline"
    flyline key bind Alt+Right "bufferIsEmpty=insertString(nextd)+submitOrNewline"
    flyline key bind Alt+Up "bufferIsEmpty=insertString(cd ..)+submitOrNewline"
    flyline key bind Alt+Down "bufferIsEmpty=insertString(l)+submitOrNewline"
    flyline key bind Alt+Shift+Down "bufferIsEmpty=insertString(l --long)+submitOrNewline"
}

# Environment variables ----------------------------------------------------------------------------

export HISTCONTROL="ignorespace:erasedups"
export EDITOR="hx"
export VISUAL="${EDITOR}"

# Aliases ------------------------------------------------------------------------------------------

alias l="eza --almost-all --git --header --icons --group-directories-first --no-quotes"
alias md="mkdir -p"
alias d="trash-put"
alias a="7z"
alias g="git"
alias e="${EDITOR}"

# Functions ----------------------------------------------------------------------------------------

prevd() { [[ "${#dirprev[@]}" -gt 0 ]] && { builtin cd "${dirprev[-1]}" && { dirnext+=("${OLDPWD}"); l; }; unset 'dirprev[${#dirprev[@]}-1]'; }; }
nextd() { [[ "${#dirnext[@]}" -gt 0 ]] && { builtin cd "${dirnext[-1]}" && { dirprev+=("${OLDPWD}"); l; }; unset 'dirnext[${#dirnext[@]}-1]'; }; }
cd() { builtin cd "$@" && { [[ "${PWD}" != "${OLDPWD}" ]] && dirprev+=("${OLDPWD}"); dirnext=(); l; }; }

s() { s=(); for path in "$@"; do s+=("$(readlink -f "${path}")"); done }
m() { [[ "${#s[@]}" -gt 0 ]] && mv "${s[@]}" . && s=(); }
c() { [[ "${#s[@]}" -gt 0 ]] && cp -r "${s[@]}" .; }
sl() { [[ "${#s[@]}" -gt 0 ]] && ln -s "${s[@]}" .; }
hl() { [[ "${#s[@]}" -gt 0 ]] && ln "${s[@]}" .; }

# Startup ------------------------------------------------------------------------------------------

[[ -x /home/linuxbrew/.linuxbrew/bin/brew ]] && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
[[ -x ~/.linuxbrew/bin/brew ]] && eval "$(~/.linuxbrew/bin/brew shellenv)"

command -v starship >/dev/null && eval "$(starship init bash)"
