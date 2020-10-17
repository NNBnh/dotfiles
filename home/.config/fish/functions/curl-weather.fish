# Defined in - @ line 1
function curl-weather --wraps='curl --silent V2.wttr.in' --description 'alias curl-weather curl --silent V2.wttr.in'
  curl --silent V2.wttr.in $argv;
end
