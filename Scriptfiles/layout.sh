#!/bin/sh

rofi_command="rofi"

# Options
if [[ $(bspc subscribe -c 1 report | cut -f 2- -d ":" | cut -f 2 -d "L" | cut -f 1 -d ":") = "M" ]]
then
	stack="舘 Stackn't"
else
	stack=" Stack"
fi
max=" Max"
view=" View"
a43=" 4:3"
gap=" 16:9"
full=" Fill"
nes=" NES"
snes=" SNES"
gb=" GB"
gba=" GBA"

options="$stack\n$max\n$view\n$a43\n$gap\n$full\n$nes\n$snes\n$gb\n$gba"

chosen="$(echo -e "$options" | $rofi_command -p "Layout" -dmenu)"
case $chosen in
	$stack)
		bspc desktop -l next
		case $(bspc subscribe -c 1 report | cut -f 2- -d ":" | cut -f 2 -d "L" | cut -f 1 -d ":") in
			"M")
				for othernodes in $(bspc query -N -n .local)
				do
					picom-trans -w $othernodes -o 0
				done
				picom-trans -c -o 100
			;;
			"T")
				for othernodes in $(bspc query -N -n .local)
				do
					picom-trans -w $othernodes -o 100
				done
			;;
		esac
		;;
	$max)
		bspc node focused -t \~fullscreen
		;;
	$view)
		bspc config -d any.focused top_padding               32
		bspc config -d any.focused bottom_padding             0
		bspc config -d any.focused left_padding              32
		bspc config -d any.focused right_padding            691
		;;
	$a43)
		bspc config -d any.focused top_padding               16
		bspc config -d any.focused bottom_padding             0
		bspc config -d any.focused left_padding             203
		bspc config -d any.focused right_padding            203
		;;
	$gap)
		bspc config -d any.focused top_padding               16
		bspc config -d any.focused bottom_padding             0
		bspc config -d any.focused left_padding              43
		bspc config -d any.focused right_padding             43
		;;
	$full)
		bspc config -d any.focused top_padding                0
		bspc config -d any.focused bottom_padding             0
		bspc config -d any.focused left_padding               0
		bspc config -d any.focused right_padding              0
		;;
	$nes)
		bspc config -d any.focused top_padding               16
		bspc config -d any.focused bottom_padding             0
		bspc config -d any.focused left_padding             299
		bspc config -d any.focused right_padding            299
		;;
	$snes)
		bspc config -d any.focused top_padding               16
		bspc config -d any.focused bottom_padding             0
		bspc config -d any.focused left_padding             272
		bspc config -d any.focused right_padding            271
		;;
	$gb)
		bspc config -d any.focused top_padding               16
		bspc config -d any.focused bottom_padding             0
		bspc config -d any.focused left_padding             283
		bspc config -d any.focused right_padding            283
		;;
	$gba)
		bspc config -d any.focused top_padding               16
		bspc config -d any.focused bottom_padding             0
		bspc config -d any.focused left_padding             143
		bspc config -d any.focused right_padding            143
		;;
esac

exit
