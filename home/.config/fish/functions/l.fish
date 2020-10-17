# Defined in - @ line 1
function l --wraps=ls --wraps='exa --all --group-directories-first --long --header --git' --description 'alias l exa --all --group-directories-first --long --header --git'
  exa --all --group-directories-first --long --header --git $argv;
end
