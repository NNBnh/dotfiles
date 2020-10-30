# Defined in - @ line 1
function v --wraps='$EDITOR' --wraps=kak --description 'alias v $EDITOR'
  $EDITOR $argv;
end
