#!/bin/sh


# Start
[ "$(dunstify --replace '999999999' --action 'cal,more' "$(date +'%I:%M %p')" "$(swaymsg --raw --type get_workspaces | jq --raw-output '.[] | "\(.focused)\(.name)\(.focused)"' | sed -e 's/^false//g' -e 's/false$//g' -e 's/^true/<u>/g' -e 's/true$/<\/u>/g' | tr '\n' ' ')")" = 'cal' ] && {
	DAY=$(date +'%e')

	dunstify 'Calendar' "$(cal | sed -e "s/$DAY\b/<u>$DAY<\/u>/g")"
}


exit 0
