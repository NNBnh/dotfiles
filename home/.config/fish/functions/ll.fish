# Defined in - @ line 1
function ll --wraps=ls --wraps='exa --all --group-directories-first --long --header --git' --description 'alias ll exa --all --group-directories-first --long --header --git'
  exa --all --group-directories-first --long --header --git $argv;
end
