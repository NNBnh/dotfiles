#     ____  __  ______
#    / __ )/ / / /  _/
#   / __  / / / // /
#  / /_/ / /_/ // /
# /_____/\____/___/

# File:         bui.kak
# Description:  BUI for Kakoune
# Author:       NNB
#               └─ https://github.com/NNBnh
# URL:          https://github.com/NNBnh/bui.kak
# License:      GPLv3

#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <https://www.gnu.org/licenses/>.


evaluate-commands %sh{
	# Values
	i='0'

	while [ "$i" -le 22 ]; do
		case $i in
			'0')  element='base00'        ; check=${BUI_COLOR_BASE00:-black}                ;;
			'1')  element='base01'        ; check=${BUI_COLOR_BASE01:-black}                ;;
			'2')  element='base02'        ; check=${BUI_COLOR_BASE02:-black}                ;;
			'3')  element='base03'        ; check=${BUI_COLOR_BASE03:-bright-black}         ;;
			'4')  element='base04'        ; check=${BUI_COLOR_BASE04:-white}                ;;
			'5')  element='base05'        ; check=${BUI_COLOR_BASE05:-bright-white}         ;;
			'6')  element='base06'        ; check=${BUI_COLOR_BASE06:-bright-white}         ;;
			'7')  element='base07'        ; check=${BUI_COLOR_BASE07:-bright-white}         ;;
			'8')  element='base08'        ; check=${BUI_COLOR_BASE08:-red}                  ;;
			'9')  element='base09'        ; check=${BUI_COLOR_BASE09:-yellow}               ;;
			'10') element='base0a'        ; check=${BUI_COLOR_BASE0A:-yellow}               ;;
			'11') element='base0b'        ; check=${BUI_COLOR_BASE0B:-green}                ;;
			'12') element='base0c'        ; check=${BUI_COLOR_BASE0C:-cyan}                 ;;
			'13') element='base0d'        ; check=${BUI_COLOR_BASE0D:-blue}                 ;;
			'14') element='base0e'        ; check=${BUI_COLOR_BASE0E:-magenta}              ;;
			'15') element='base0f'        ; check=${BUI_COLOR_BASE0F:-red}                  ;;
			'16') element='foreground'    ; check=${BUI_COLOR_FOREGROUND:-foreground}       ;;
			'17') element='background'    ; check=${BUI_COLOR_BACKGROUND:-background}       ;;
			'18') element='foreground_alt'; check=${BUI_COLOR_FOREGROUND_ALT:-bright-black} ;;
			'19') element='background_alt'; check=${BUI_COLOR_BACKGROUND_ALT:-black}        ;;
			'20') element='cursor'        ; check=${BUI_COLOR_CURSOR:-bright-white}         ;;
			'21') element='cursor_alt'    ; check=${BUI_COLOR_CURSOR_ALT:-white}            ;;
			'22') element='selection'     ; check=${BUI_COLOR_SELECTION:-bright-black}      ;;
		esac

		case $check in
			"${BUI_COLOR_FOREGROUND:-foreground}")      eval "${element}_fg=\"default\"        ; ${element}_bg=\"bright-white\""    ;;
			"${BUI_COLOR_BACKGROUND:-background}")      eval "${element}_fg=\"black\"          ; ${element}_bg=\"default\""         ;;
			"${BUI_COLOR_TERMINAL000:-black}")          eval "${element}_fg=\"black\"          ; ${element}_bg=\"black\""           ;;
			"${BUI_COLOR_TERMINAL001:-red}")            eval "${element}_fg=\"red\"            ; ${element}_bg=\"red\""             ;;
			"${BUI_COLOR_TERMINAL002:-green}")          eval "${element}_fg=\"green\"          ; ${element}_bg=\"green\""           ;;
			"${BUI_COLOR_TERMINAL003:-yellow}")         eval "${element}_fg=\"yellow\"         ; ${element}_bg=\"yellow\""          ;;
			"${BUI_COLOR_TERMINAL004:-blue}")           eval "${element}_fg=\"blue\"           ; ${element}_bg=\"blue\""            ;;
			"${BUI_COLOR_TERMINAL005:-magenta}")        eval "${element}_fg=\"magenta\"        ; ${element}_bg=\"magenta\""         ;;
			"${BUI_COLOR_TERMINAL006:-cyan}")           eval "${element}_fg=\"cyan\"           ; ${element}_bg=\"cyan\""            ;;
			"${BUI_COLOR_TERMINAL007:-white}")          eval "${element}_fg=\"white\"          ; ${element}_bg=\"white\""           ;;
			"${BUI_COLOR_TERMINAL008:-bright-black}")   eval "${element}_fg=\"bright-black\"   ; ${element}_bg=\"bright-black\""    ;;
			"${BUI_COLOR_TERMINAL009:-bright-red}")     eval "${element}_fg=\"bright-red\"     ; ${element}_bg=\"bright-red\""      ;;
			"${BUI_COLOR_TERMINAL010:-bright-green}")   eval "${element}_fg=\"bright-green\"   ; ${element}_bg=\"bright-green\""    ;;
			"${BUI_COLOR_TERMINAL011:-bright-yellow}")  eval "${element}_fg=\"bright-yellow\"  ; ${element}_bg=\"bright-yellow\""   ;;
			"${BUI_COLOR_TERMINAL012:-bright-blue}")    eval "${element}_fg=\"bright-blue\"    ; ${element}_bg=\"bright-blue\""     ;;
			"${BUI_COLOR_TERMINAL013:-bright-magenta}") eval "${element}_fg=\"bright-magenta\" ; ${element}_bg=\"bright-magenta\""  ;;
			"${BUI_COLOR_TERMINAL014:-bright-cyan}")    eval "${element}_fg=\"bright-cyan\"    ; ${element}_bg=\"bright-cyan\""     ;;
			"${BUI_COLOR_TERMINAL015:-bright-white}")   eval "${element}_fg=\"bright-white\"   ; ${element}_bg=\"bright-white\""    ;;
			*)                                          eval "${element}_fg=\"rgb:${check#\#}\"; ${element}_bg=\"rgb:${check#\#}\"" ;;
		esac

		i=$(( i + 1 ))
	done

	[ "$kak_opt_bui_cursor_information" = 'true' ] && information='MenuForeground'


	# Start
		# UI
		echo "
			# Normal
			face global Default             $foreground_fg,$background_bg
			face global PrimarySelection    $background_fg,$selection_bg+fg
			face global SecondarySelection  PrimarySelection
			face global PrimaryCursor       $background_fg,$cursor_bg+fg
			face global SecondaryCursor     $background_fg,$cursor_alt_bg+fg
			face global PrimaryCursorEol    PrimaryCursor
			face global SecondaryCursorEol  SecondaryCursor

			# Line number
			face global LineNumbers         $foreground_alt_fg,$background_alt_bg
			face global LineNumberCursor    $cursor_fg,$background_alt_bg
			face global LineNumbersWrapped  $background_alt_fg,$background_alt_bg

			# Status bar
			face global StatusLine          $foreground_fg,$background_alt_bg
			face global StatusLineInfo      $cursor_fg
			face global StatusLineMode      StatusLineInfo
			face global StatusLineValue     StatusLineInfo
			face global MenuForeground      $background_fg,$cursor_bg
			face global MenuBackground      $foreground_fg,$background_alt_bg
			face global MenuInfo            $foreground_alt_fg
			face global Information         ${information:-$foreground_fg,$background_alt_bg}
			face global Prompt              Information
			face global StatusCursor        PrimaryCursor

			# Other
			face global Error               $background_fg,$base08_bg+fg
			face global MatchingChar        $foreground_fg,$background_alt_bg
			face global BufferPadding       $background_alt_fg,$background_alt_bg
			face global Whitespace          $background_alt_fg+f
			face global WrapMarker          Whitespace
		"

		# Syntax
		echo "
			# Code
			face global value               $base09_fg+b
			face global type                $base0a_fg
			face global variable            $base08_fg
			face global module              $base0b_fg
			face global function            $base0d_fg
			face global string              $base0b_fg
			face global keyword             $base0e_fg+b
			face global operator            $base0d_fg
			face global attribute           $base09_fg
			face global comment             $base03_fg+i
			face global documentation       comment
			face global meta                $base0a_fg
			face global builtin             $foreground_fg+b

			# Markdown
			face global title               $foreground_fg+b
			face global header              $base0d_fg
			face global mono                $base0b_fg
			face global block               $base09_fg
			face global link                $base0c_fg+u
			face global bullet              $base08_fg
			face global list                $base08_fg
		"
}
