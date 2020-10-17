#!/bin/sh

if [[ $1 = "-3" ]]
then
	youtube-dl $2 --add-metadata --embed-thumbnail --extract-audio \
	--audio-format mp3 \
	-o "~/Downloads/%(title)s.%(ext)s" $f
else
	youtube-dl $1 -f "bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best" \
	-o "~/Downloads/%(title)s.%(ext)s" $f
fi

exit
