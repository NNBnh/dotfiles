# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block, everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source ~/.local/share/zsh/plugins/powerlevel10k/powerlevel10k.zsh-theme
source ~/.local/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
source ~/.local/share/zsh/plugins/git.plugin.zsh
source ~/.local/share/zsh/plugins/archlinux.plugin.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh

# Setting for ibus
export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus
export CLUTTER_IM_MODULE=ibus
export LC_CTYPE=vi_VN.UTF-8

# Setting for fzf
export FZF_DEFAULT_OPTS='--height 15 --layout=reverse --tabstop=4
--color fg:15,bg:-1,hl:15,fg+:0,bg+:11,hl+:0
--color gutter:-1,info:11,prompt:11,spinner:11,pointer:11,marker:8
'
export FZF_DEFAULT_COMMAND='fd --hidden --follow --exclude "Games"'
_fzf_compgen_path() {
  fd --hidden --follow --exclude "Games" . "$1"
}
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude "Games" . "$1"
}


#### Alias
# Rsync
alias rsync-copy="rsync -avz --progress -h"
alias rsync-move="rsync -avz --progress -h --remove-source-files"
alias rsync-update="rsync -avzu --progress -h"
alias rsync-synchronize="rsync -avzu --delete --progress -h"

# Application & More
alias q="exit"
alias fresh="sh "$HOME/Dotfiles/Cloud/Scriptfiles/fresh.sh""
alias fetch="sh "$HOME/Dotfiles/Cloud/Scriptfiles/fetch.sh""

alias fm="vifm"
alias v="nvim"
alias mc="minecraft-launcher"
alias taskmana="glances"
alias hackerman="unimatrix -s 95"

alias rickroll="curl -s -L https://raw.githubusercontent.com/keroserene/rickrollrc/master/roll.sh | bash"
alias bcww="curl -s -L https://raw.githubusercontent.com/keroserene/rickrollrc/master/roll.sh | bash"
alias rick="echo 'curl -s -L http://bit.ly/10hA8iC | bash' | xclip -selection clipboard"
alias dlm="sh "$HOME/Dotfiles/Cloud/Scriptfiles/dlm.sh""
alias dlm3="sh "$HOME/Dotfiles/Cloud/Scriptfiles/dlm.sh" -3"
alias screeny="sh "$HOME/Dotfiles/Cloud/Scriptfiles/screeny.sh""
alias git-push="sh "$HOME/Dotfiles/Cloud/Scriptfiles/gitpush.sh""

alias dget-class="xprop"
alias dget-key="xev"
alias dget-font="fc-list"


#### Keybinding
### Movements
bindkey '^[i' up-line-or-history
bindkey '^[I' up-history
bindkey '^[k' down-line-or-history
bindkey '^[K' down-history
bindkey '^[j' backward-char
bindkey '^[J' emacs-backward-word
bindkey '^[l' forward-char
bindkey '^[L' emacs-forward-word

	## Advance
	bindkey '^[u' emacs-backward-word
	bindkey '^[o' emacs-forward-word
	bindkey '^[n' beginning-of-line
	bindkey '^[m' end-of-line

### Selecet
	bindkey '^[s' visual-mode
	bindkey '^[S' visual-line-mode

### Edits
	## Deletes
	bindkey '^[e' backward-delete-char
	bindkey '^[E' vi-delete

	## Clipboards
	bindkey '^[d' vi-delete
	bindkey '^[x' vi-delete
	bindkey '^[c' vi-yank
	bindkey '^[v' vi-put-after

	## Undo
	bindkey '^[f' undo
	bindkey '^[F' redo
	bindkey '^[z' undo
	bindkey '^[Z' redo

### Files
bindkey '^[r^[t' clear-screen


#### Autostarts

sh "$HOME/Dotfiles/Cloud/Scriptfiles/fetch.sh"

