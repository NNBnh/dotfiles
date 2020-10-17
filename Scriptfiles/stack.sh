#!/bin/sh

bspc subscribe node_focus | while read -r _ _ _ l
do
	if [[ $(bspc subscribe -c 1 report | cut -f 2- -d ":" | cut -f 2 -d "L" | cut -f 1 -d ":") = "M" ]]
	then
		for othernodes in $(bspc query -N -n .local)
		do
			picom-trans -w $othernodes -o 0
		done
		picom-trans -c -o 100
	fi
done

exit
