# Defined in - @ line 1
function ll --wraps='exa --all --group-directories-first --long --header --git' --description 'alias ll exa --all --group-directories-first --long --header --git'
  exa --color='always' --all --group-directories-first --long --header --git $argv;
end
