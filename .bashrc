#!/usr/bin/env bash

# Options ------------------------------------------------------------------------------------------

shopt -s autocd dotglob globstar nullglob

[[ -f ~/.local/lib/libflyline.so ]] || curl -fsSL "https://github.com/HalFrgrd/flyline/releases/latest/download/install.sh" | sh
enable -f ~/.local/lib/libflyline.so flyline
flyline set-cursor --backend terminal --interpolate none
flyline suggestions --sort-order alphabetical
flyline key bind Ctrl+a "always=selectAll"
flyline key bind Right "bufferIsEmpty=insertString(cd )"
flyline key bind Alt+Left "bufferIsEmpty=insertString(prevd)+submitOrNewline"
flyline key bind Alt+Right "bufferIsEmpty=insertString(nextd)+submitOrNewline"
flyline key bind Alt+Up "bufferIsEmpty=insertString(cd ..)+submitOrNewline"
flyline key bind Alt+Down "bufferIsEmpty=insertString(l)+submitOrNewline"
flyline key bind Alt+Shift+Down "bufferIsEmpty=insertString(l --long)+submitOrNewline"

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

dirprev=()
dirnext=()
prevd() { [[ "${#dirprev[@]}" -gt 0 ]] && { builtin cd "${dirprev[-1]}" && { dirnext+=("${OLDPWD}"); l; }; unset 'dirprev[${#dirprev[@]}-1]'; }; }
nextd() { [[ "${#dirnext[@]}" -gt 0 ]] && { builtin cd "${dirnext[-1]}" && { dirprev+=("${OLDPWD}"); l; }; unset 'dirnext[${#dirnext[@]}-1]'; }; }
cd() { builtin cd "$@" && { [[ "${PWD}" != "${OLDPWD}" ]] && dirprev+=("${OLDPWD}"); dirnext=(); l; }; }

s() { s=(); for path in "$@"; do s+=("$(readlink -f "${path}")"); done }
m() { [[ "${#s[@]}" -gt 0 ]] && mv "${s[@]}" . && s=(); }
c() { [[ "${#s[@]}" -gt 0 ]] && cp -r "${s[@]}" .; }
sl() { [[ "${#s[@]}" -gt 0 ]] && ln -s "${s[@]}" .; }
hl() { [[ "${#s[@]}" -gt 0 ]] && ln "${s[@]}" .; }

# Startup ------------------------------------------------------------------------------------------

brew-shellenv() {
    [[ -x /home/linuxbrew/.linuxbrew/bin/brew ]] && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    [[ -x ~/.linuxbrew/bin/brew ]] && eval "$(~/.linuxbrew/bin/brew shellenv)"
}

brew-shellenv

command -v starship >/dev/null || {
    command -v brew >/dev/null || {
        bash -c "$(curl -fsSL "https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh")"
        brew-shellenv
    }
    brew install starship eza helix p7zip trash-cli bun gleam ruby
    gem install rubyshell
}

eval "$(starship init bash)"
