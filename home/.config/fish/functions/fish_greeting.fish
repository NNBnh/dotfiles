function fish_greeting --wraps=bfetch --description 'fish greeting'
	bui-terminal
	bfetch
	stty intr '^X' susp '^P' eof '^Q' start '^A' stop '^E' -echo
end
