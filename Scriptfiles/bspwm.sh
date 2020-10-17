#!/bin/sh

if [[ $1 = "--$(bspc query -D --names -d focused.occupied.local)" ]]
then
	if [[ $2 = "--prev" ]]
	then
		bspc node -f prev.local
	else
		bspc node -f next.local
	fi
else
	case "$1" in
		"--info")
			bspc desktop -f 'info'
			;;
		"--term")
			bspc rule -a Alacritty desktop='term' follow=on
			bspc desktop -f 'term'.occupied.local || alacritty
			bspc rule -r Alacritty
			;;
		"--text")
			bspc desktop -f 'text'.occupied.local || alacritty --class text,text -e nvim
			;;
		"--draw")
			bspc desktop -f 'draw'.occupied.local || gimp
			;;
		"--webs")
			bspc desktop -f 'webs'.occupied.local || firefox
			;;
		"--work")
			bspc desktop -f 'work'.occupied.local || godot
			;;
		"--game")
			bspc desktop -f 'game'.occupied.local || retroarch
			;;
	esac
fi

exit

