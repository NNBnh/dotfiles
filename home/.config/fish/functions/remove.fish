# Defined in - @ line 1
function remove --wraps=trash-put --wraps=rm --description 'alias remove rm'
  rm  $argv;
end
