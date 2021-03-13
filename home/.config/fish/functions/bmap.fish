function bmap --description 'Fish key-mapping that SuperB'
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


	bind --preset \cx __fish_cancel_commandline
	bind --preset \cc fish_clipboard_copy
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

	bind --preset \ey "commandline --insert (echo ($FINDER --multi)); commandline --function repaint"
	bind --preset \eY "commandline --insert (echo (chpick));          commandline --function repaint"

	bind --preset \es edit_command_buffer

	bind --preset \ex backward-delete-char
	bind --preset \eX kill-line

	bind --preset \ec fish_clipboard_copy

	bind --preset \ev fish_clipboard_paste

	bind --preset \ed execute

	bind --preset \ef __fish_cancel_commandline

	bind --preset \e\; __fish_prepend_sudo

	bind --preset \er "echo -n (clear | string replace \e\\[3J \"\"); commandline --function repaint"

	bind --preset \e/ __fish_toggle_comment_commandline
end
