function l --wraps="$LIST --all --group-directories-first --long --header --git --colour='always'" --description "Alias for $LIST --all --group-directories-first --long --header --git --colour='always'"
	eval "$LIST --all --group-directories-first --long --header --git --colour='always' \$argv"
end
