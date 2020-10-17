#!/bin/sh

case $1 in
	"--full")
		pactl set-sink-mute 0 toggle
		;;
	"--down")
		pactl set-sink-volume 0 -5%
		;;
	"--up")
		pactl set-sink-volume 0 +5%
		;;
esac

if [[ $(pamixer --get-mute) = "true" ]]
then
	dunstify -r 766675 -b "Volume" "$(pamixer --get-volume) mute"
else
	dunstify -r 766675 -b "Volume" "$(pamixer --get-volume)"
fi

exit
