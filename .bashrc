#!/usr/bin/env bash

command -v brew >/dev/null || {
    { test -d ~/.linuxbrew || test -d /home/linuxbrew/.linuxbrew; } \
    || bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    test -d ~/.linuxbrew && eval "$(~/.linuxbrew/bin/brew shellenv)"
    test -d /home/linuxbrew/.linuxbrew && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
}
command -v brew >/dev/null && {
    command -v starship >/dev/null || brew install starship
    command -v eza      >/dev/null || brew install eza
    command -v fd       >/dev/null || brew install fd
    command -v rg       >/dev/null || brew install ripgrep
    command -v bat      >/dev/null || brew install bat
    command -v hx       >/dev/null || brew install helix
    command -v 7z       >/dev/null || brew install p7zip
    command -v trash    >/dev/null || brew install trash-cli
    command -v bun      >/dev/null || brew install oven-sh/bun/bun
    command -v gleam    >/dev/null || brew install gleam
    command -v ruby     >/dev/null || { brew install ruby && gem install rubyshell; }
}

test -f "${HOME}/.local/lib/libflyline.so" \
|| curl -fsSL "https://github.com/HalFrgrd/flyline/releases/latest/download/install.sh" | sh
test -f "${HOME}/.local/lib/libflyline.so" && enable -f "${HOME}/.local/lib/libflyline.so" flyline
command -v flyline >/dev/null && {
    flyline set-cursor --backend terminal --interpolate none
    #flyline key bind Ctrl+a "always=SelectAll"
    flyline key bind Alt+Up "always=clearBuffer+insertString(cd ..)+submitOrNewline"
    flyline key bind Alt+Down "always=clearBuffer+insertString(l)+submitOrNewline"
    flyline key bind Alt+Shift+Down "always=clearBuffer+insertString(l --long)+submitOrNewline"
}

shopt -s autocd dotglob globstar nullglob

export HISTCONTROL="ignorespace:erasedups"
export EDITOR="hx"
export VISUAL="${EDITOR}"

alias l="eza --almost-all --git --header --icons --group-directories-first --no-quotes"
alias md="mkdir -p"
alias d="trash-put"
alias a="7z"
alias e="${EDITOR}"

s()  { s=(); for path in "$@"; do s+=("$(readlink -f "${path}")"); done }
m()  { command mv    "${s[@]}" .; }
c()  { command cp -r "${s[@]}" .; }
sl() { command ln -s "${s[@]}" .; }
hl() { command ln    "${s[@]}" .; }

command -v starship >/dev/null && eval "$(starship init bash)"
