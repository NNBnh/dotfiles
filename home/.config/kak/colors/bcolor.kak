evaluate-commands %sh{
	ui_background=${kak_opt_ui_background-'black'}
	if [[ $kak_opt_bcolor_light == 'true' ]]; then
		foreground_primary='black'
		foreground_secondary='bright-black'
		background_primary='bright-white'
		background_secondary='white'
	else
		foreground_primary='bright-white'
		foreground_secondary='white'
		background_primary='black'
		background_secondary='bright-black'
	fi
	brown=${kak_opt_bcolor_brown-'red'}
	red=${kak_opt_bcolor_red-'red'}
	green=${kak_opt_bcolor_green-'green'}
	lime=${kak_opt_bcolor_lime-'green'}
	orange=${kak_opt_bcolor_orange-'yellow'}
	yellow=${kak_opt_bcolor_yellow-'yellow'}
	purple=${kak_opt_bcolor_purple-'blue'}
	blue=${kak_opt_bcolor_blue-'blue'}
	magenta=${kak_opt_bcolor_magenta-'magenta'}
	pink=${kak_opt_bcolor_pink-'magenta'}
	tear=${kak_opt_bcolor_tear-'cyan'}
	cyan=${kak_opt_bcolor_cyan-'cyan'}
	main=${kak_opt_bcolor_main-'blue'}
	[[ $kak_opt_bcolor_main_light == 'true' ]] \
		&& main_foreground='black' \
		|| main_foreground='bright-white'

	if [[ $kak_opt_bcolor_cursor_main == 'true' ]]; then
		cursor_primary=$main
		cursor_primary_foreground=$main_foreground
	else
		cursor_primary=$foreground_primary
		cursor_primary_foreground=$background_primary
	fi
	cursor_secondary=$foreground_secondary
	cursor_secondary_foreground=$background_primary

	if [[ $kak_opt_bcolor_status_main == 'true' ]]; then
			status_foreground=$main_foreground
			status_background=$main
			status_info=$main_foreground
	else
			status_foreground=$foreground_primary
			status_background=$ui_background
			status_info=$main
	fi

	[[ $kak_opt_bcolor_bright == 'false' ]] || bright='bright-'


	# UI
	echo "
		# Normal
		face global Default             default,default
		face global PrimarySelection    $background_primary,$background_secondary+fg
		face global SecondarySelection  PrimarySelection
		face global PrimaryCursor       $cursor_primary_foreground,$cursor_primary+fg
		face global SecondaryCursor     $cursor_secondary_foreground,$cursor_secondary+fg
		face global PrimaryCursorEol    PrimaryCursor
		face global SecondaryCursorEol  SecondaryCursor

		# Other
		face global Error               red,default+rfg
		face global MatchingChar        default,$ui_background
		face global BufferPadding       $background_primary,$background_primary
		face global Whitespace          $background_secondary+f
		face global WrapMarker          Whitespace

		# Line number
		face global LineNumbers         $background_secondary,$background_primary
		face global LineNumberCursor    $cursor_primary,$background_primary
		face global LineNumbersWrapped  $background_primary,$background_primary

		# Status bar
		face global StatusLine          $status_foreground,$status_background
		face global StatusLineInfo      $status_info
		face global StatusLineMode      StatusLineInfo
		face global StatusLineValue     StatusLineInfo
		face global MenuForeground      $cursor_primary_foreground,$cursor_primary
		face global MenuBackground      $foreground_primary,$ui_background
		face global MenuInfo            $background_secondary
		face global Information         $main_foreground,$main
		face global Prompt              Information
		face global StatusCursor        $cursor_primary,$cursor_primary_foreground+fg
		hook global ModeChange push:.*:prompt %{
			face global StatusLine      $foreground_primary,$background_primary
			face global StatusLineInfo  $main
			face global StatusCursor    $cursor_primary_foreground,$cursor_primary+fg
		}
		hook global ModeChange pop:prompt:.* %{
			face global StatusLine      $status_foreground,$status_background
			face global StatusLineInfo  $status_info
			face global StatusCursor    $cursor_primary,$cursor_primary_foreground+fg
		}
	"

	# Syntax
	echo "
		# Code
		face global value               $orange+b
		face global type                ${bright}yellow
		face global variable            ${bright}red
		face global module              ${bright}green
		face global function            ${bright}blue
		face global string              ${bright}green
		face global keyword             ${bright}magenta+b
		face global operator            ${bright}blue
		face global attribute           $orange
		face global comment             $background_secondary+i
		face global documentation       comment
		face global meta                ${bright}yellow
		face global builtin             default+b

		# Markdown
		face global title               default+b
		face global header              ${bright}blue
		face global mono                ${bright}green
		face global block               $orange
		face global link                ${bright}cyan+u
		face global bullet              ${bright}red
		face global list                ${bright}red
	"
}
