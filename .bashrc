#!/usr/bin/env bash

shopt -s autocd dotglob globstar nullglob

export HISTCONTROL="ignorespace:erasedups"
export EDITOR="hx"
export VISUAL="${EDITOR}"

alias l="eza --almost-all --git --header --icons --group-directories-first --no-quotes"
alias md="mkdir -p"
alias d="trash-put"
alias a="7z"
alias g="git"
alias e="${EDITOR}"

cd() { builtin cd "$@" && l; }
s()  { s=(); for path in "$@"; do s+=("$(readlink -f "${path}")"); done }
m()  { command mv    "${s[@]}" .; }
c()  { command cp -r "${s[@]}" .; }
sl() { command ln -s "${s[@]}" .; }
hl() { command ln    "${s[@]}" .; }

[[ -f "${HOME}/.local/lib/libflyline.so" ]] || curl -fsSL "https://github.com/HalFrgrd/flyline/releases/latest/download/install.sh" | sh
enable -f "${HOME}/.local/lib/libflyline.so" flyline
flyline set-cursor --backend terminal --interpolate none
flyline key bind Ctrl+a         "always=selectAll"
flyline key bind Right          "bufferIsEmpty=insertString(./)"
flyline key bind Alt+Up         "bufferIsEmpty=insertString(cd ..)+submitOrNewline"
flyline key bind Alt+Down       "bufferIsEmpty=insertString(l)+submitOrNewline"
flyline key bind Alt+Shift+Down "bufferIsEmpty=insertString(l --long)+submitOrNewline"

brew-shellenv() {
    [[ -x "/home/linuxbrew/.linuxbrew/bin/brew" ]] && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    [[ -x "~/.linuxbrew/bin/brew" ]] && eval "$(~/.linuxbrew/bin/brew shellenv)"
}

install-wizard() {
    { command -v brew >/dev/null || command -v pkg >/dev/null; } || {
        bash -c "$(curl -fsSL "https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh")"
        brew-shellenv
    }
    command -v brew >/dev/null && brew install starship eza fd ripgrep helix p7zip trash-cli bun gleam ruby
    command -v pkg >/dev/null && pkg install --yes starship eza fd ripgrep helix 7zip python-trash-cli gleam ruby
    command -v bun >/dev/null || curl -fsSL https://bun.com/install | bash
    command -v gem >/dev/null && gem install rubyshell
}

brew-shellenv

command -v starship >/dev/null || install-wizard && eval "$(starship init bash)"
