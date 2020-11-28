# Defined in - @ line 1
function fish_greeting --wraps=bfetch --description 'fish greeting'
  bfetch  $argv;
end
