#!/bin/sh

case $1 in
	"--full")
		picom-trans -c -o 100
		;;
	"--hide")
		picom-trans -c -o 5
		;;
	"--down")
		picom-trans -c -o -10
		;;
	"--up")
		picom-trans -c -o +10
		;;
esac

exit
