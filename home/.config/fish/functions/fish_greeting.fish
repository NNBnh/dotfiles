function fish_greeting --wraps=bfetch --description 'fish greeting'
	stty intr '^X' susp '^P' eof '^Q' start '^A' stop '^E' -echo
	bui-terminal
	bfetch
	starship init fish | source
end
