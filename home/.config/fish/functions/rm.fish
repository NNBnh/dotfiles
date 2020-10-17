# Defined in - @ line 1
function rm --wraps=trash-put --description 'alias rm trash-put'
  trash-put $argv;
end
