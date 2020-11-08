# Defined in - @ line 1
function e --wraps="$EDITOR" --description "alias v $EDITOR"
  $EDITOR $argv;
end
