# Defined in - @ line 1
function ls --wraps='exa --group-directories-first -a' --description 'alias ls exa --group-directories-first -a'
  exa --group-directories-first -a $argv;
end
