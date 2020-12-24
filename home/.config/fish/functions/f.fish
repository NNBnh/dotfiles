function f --wraps="bfm" --description "Alias for bfm"
	bfm
    [ -n "$TMPDIR" ] && set TMPDIR /tmp
	cd (cat $TMPDIR/bfm)
end
