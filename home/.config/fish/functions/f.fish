function f --wraps="bfm" --description "Alias for bfm"
	bfm "$PWD" "$fish_pid"
    [ -n "$TMPDIR" ] && set --local TMPDIR /tmp
	cd (cat "$TMPDIR/bfm_$fish_pid/pwd")
end
