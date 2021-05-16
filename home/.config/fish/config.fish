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


"$HOME/.config/env/rc" | source

abbr e "$EDITOR"
abbr g "git"
abbr o "xdg-open"
abbr l "ls -Ahl"

alias ifjson "curl --silent --location 'ifconfig.co/json'"
alias roll "curl --silent --location 'https://raw.githubusercontent.com/keroserene/rickrollrc/master/roll.sh' | bash"
alias rollout "clipb copy 'curl -sL http://bit.ly/10hA8iC | bash'"

function cht   --description   'cheat.sh'; curl --silent --location   "cheat.sh/$argv"; end
function wttr  --description    'wttr.in'; curl --silent --location    "wttr.in/$argv"; end
function wttr2 --description 'v2.wttr.in'; curl --silent --location "v2.wttr.in/$argv"; end
function rate  --description    'rate.sx'; curl --silent --location    "rate.sx/$argv"; end
function 0x0   --description     '0x0.st'; curl --form "$argv[1]=$argv[2]" --location "0x0.st"; end

function fish_title
	prompt_pwd
end

diyship init fish | source



function __fish_commandline_insert_escaped --description 'Insert the first arg escaped if a second arg is given'
	if set -q argv[2]
		commandline --insert \\$argv[1]
	else
		commandline --insert $argv[1]
	end
end

function __fish_start_bracketed_paste
	# Save the last bind mode so we can restore it.
	set --global __fish_last_bind_mode $fish_bind_mode
	# If the token is currently single-quoted,
	# we escape single-quotes (and backslashes).
	__fish_commandline_is_singlequoted
	and set --global __fish_paste_quoted 1
end

function __fish_stop_bracketed_paste
	# Restore the last bind mode.
	set fish_bind_mode $__fish_last_bind_mode
	set --erase __fish_paste_quoted
end

function bmap --description 'Fish key-mapping that SuperB'
	bind --preset \e\[I       'emit fish_focus_in'
	bind --preset \e\[O       false
	bind --preset \e\[\?1004h false
	bind --preset --sets-mode paste \e\[200\~ __fish_start_bracketed_paste
	bind --preset --mode      paste \e\[201\~ __fish_stop_bracketed_paste
	bind --preset --mode      paste --key a1 self-insert
	bind --preset --mode      paste \r "commandline --insert \\n"
	bind --preset --mode      paste \' "__fish_commandline_insert_escaped \\' $__fish_paste_quoted"
	bind --preset --mode      paste \\ "__fish_commandline_insert_escaped \\\\ $__fish_paste_quoted"
	bind --preset --mode      paste ' ' self-insert-notfirst
	bind --preset --key a1    self-insert
	bind --preset ' '         self-insert expand-abbr


	bind --preset --key f1 __fish_man_page

	bind --preset --key up  up-or-search
	bind --preset \e\[A     up-or-search
	bind --preset \e\[1\;2A beginning-of-buffer
	bind --preset \e\[3A    history-token-search-backward
	bind --preset \e\e\[A   history-token-search-backward
	bind --preset \e\[1\;3A history-token-search-backward
	bind --preset \e\[1\;9A history-token-search-backward
	bind --preset \eO3A     history-token-search-backward
	bind --preset \e\eOA    history-token-search-backward

	bind --preset --key down down-or-search
	bind --preset \e\[B      down-or-search
	bind --preset \e\[1\;2B  end-of-buffer
	bind --preset \e\[3B     history-token-search-forward
	bind --preset \e\e\[B    history-token-search-forward
	bind --preset \e\[1\;3B  history-token-search-forward
	bind --preset \e\[1\;9B  history-token-search-forward
	bind --preset \eO3B      history-token-search-forward
	bind --preset \e\eOB     history-token-search-forward

	bind --preset --key left  backward-char
	bind --preset \e\[D       backward-char
	bind --preset --key sleft backward-bigword
	bind --preset \e\[1\;5D   backward-word
	bind --preset \e\[3D      "prevd; commandline --function repaint"
	bind --preset \e\e\[D     "prevd; commandline --function repaint"
	bind --preset \e\[1\;3D   "prevd; commandline --function repaint"
	bind --preset \e\[1\;9D   "prevd; commandline --function repaint"
	bind --preset \eO3D       "prevd; commandline --function repaint"
	bind --preset \e\eOD      "prevd; commandline --function repaint"

	bind --preset --key right  forward-char
	bind --preset \e\[C        forward-char
	bind --preset --key sright forward-bigword
	bind --preset \e\[1\;5C    forward-word
	bind --preset \e\[3C       "nextd; commandline --function repaint"
	bind --preset \e\e\[C      "nextd; commandline --function repaint"
	bind --preset \e\[1\;3C    "nextd; commandline --function repaint"
	bind --preset \e\[1\;9C    "nextd; commandline --function repaint"
	bind --preset \eO3C        "nextd; commandline --function repaint"
	bind --preset \e\eOC       "nextd; commandline --function repaint"

	bind --preset --key ppage beginning-of-history
	bind --preset --key npage end-of-history
	bind --preset --key home  beginning-of-line
	bind --preset \e\[H       beginning-of-line
	bind --preset \e\[1\~     beginning-of-line
	bind --preset --key end   end-of-line
	bind --preset \e\[F       end-of-line
	bind --preset \e\[4\~     end-of-line

	bind --preset \t         complete
	bind --preset --key btab complete-and-search

	bind --preset --key dc        delete-char
	bind --preset --key sdc       backward-delete-char
	bind --preset --key backspace backward-delete-char
	bind --preset \b              backward-kill-word
	bind --preset \e\x7F          backward-kill-word

	bind --preset \e cancel

	bind --preset \n   execute
	bind --preset \r   execute
	bind --preset \e\n "commandline --insert \n"
	bind --preset \e\r "commandline --insert \n"


	bind --preset \cc __fish_cancel_commandline
	bind --preset \cx fish_clipboard_copy
	bind --preset \cv fish_clipboard_paste
	bind --preset \cr "echo -n (clear | string replace \e\\[3J \"\"); commandline --function repaint"
	bind --preset \cd exit
	bind --preset \cq exit


	bind --preset \ej backward-char
	bind --preset \eJ beginning-of-line

	bind --preset \el forward-char
	bind --preset \eL end-of-line

	bind --preset \ei up-or-search
	bind --preset \eI beginning-of-buffer

	bind --preset \ek down-or-search
	bind --preset \eK end-of-buffer

	bind --preset \eu backward-word
	bind --preset \eU backward-bigword

	bind --preset \eo forward-word
	bind --preset \eO forward-bigword

	bind --preset \eh pager-toggle-search

	bind --preset \ey "commandline --insert (find -maxdepth 1 -printf '%P\n' | sed -e '1d' | $SELECTOR --multi); commandline --function repaint"
	bind --preset \eY "commandline --insert (find             -printf '%P\n' | sed -e '1d' | $SELECTOR --multi); commandline --function repaint"

	bind --preset \es edit_command_buffer

	bind --preset \ex backward-delete-char
	bind --preset \eX kill-line

	bind --preset \ec fish_clipboard_copy

	bind --preset \ev fish_clipboard_paste

	bind --preset \ed execute

	bind --preset \ee "commandline --insert (chpick); commandline --function repaint"

	bind --preset \ef __fish_cancel_commandline

	bind --preset \e\; __fish_prepend_sudo

	bind --preset \er "echo -n (clear | string replace \e\\[3J \"\"); commandline --function repaint"

	bind --preset \e/ __fish_toggle_comment_commandline
end



function fish_greeting
	# stty intr '^X' susp '^P' eof '^Q' start '^A' stop '^E' -echo
	bfetch

	bui-terminal
end
