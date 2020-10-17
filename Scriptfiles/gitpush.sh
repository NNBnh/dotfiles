#!/bin/sh

if [ -f linux* ]
then
	echo "┌────────────────────────────────────────────┐"
	echo "│ Stopping the script!                       │"
	echo "│ Wait for the kernel update script to quit. │"
	echo "└────────────────────────────────────────────┘"
	exit 0
fi

git add --all
echo ""
echo "!!  Write your commit comment !!"
echo ""
read input_comment
curtime=$(date)
git commit -v -a --no-edit --amend -m "Comment : $input_comment on $curtime"

git pull origin $(current_branch)
echo ""
echo "!!  Write your branch name !!"
echo ""
read input_push
git push origin $(current_branch) $input_push

exit
