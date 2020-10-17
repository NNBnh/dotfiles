#!/bin/sh

case $1 in
	"--full")
		if [[ $(xbacklight -get) = "100.000000" ]]
		then
			xbacklight -set 1
		else
			xbacklight -set 100
		fi
		;;
	"--down")
		xbacklight -dec 5
		;;
	"--up")
		xbacklight -inc 5
		;;
esac

dunstify -r 766675 -b "Brightness" "$(xbacklight -get | cut -f 1 -d ".")"

exit
