# Defined in - @ line 1
function list --wraps='ls --group-directories-first --color=auto --almost-all' --description 'alias list ls --group-directories-first --color=auto --almost-all'
  ls --group-directories-first --color=auto --almost-all $argv;
end
