#!/bin/sh

time_now="$(date +%s)"

case $1 in
	"-r")
		ffmpeg -f x11grab \
		-s 1366x768 \
		-an -i :0.0 \
		-c:v libvpx \
		-b:v 5M \
		-crf 10 \
		-quality realtime \
		-y "$HOME/Desktop/$time_now.mkv"
		;;
	"-s")
		killall ffmpeg
		dunstify -b "Screeny" "stopped recording"
		;;
	"-c")
		maim -u -s "$HOME/Desktop/$time_now.png"
		pix "$HOME/Desktop/$time_now.png"
		dunstify -b "Screeny" "$time_now.png"
		;;
	"-f")
		maim -u "$HOME/Desktop/$time_now.png"
		dunstify -b "Screeny" "$time_now.png"
esac

exit
