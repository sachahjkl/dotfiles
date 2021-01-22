# Defined in - @ line 1
function l --wraps='exa --group-directories-first -a -l --icons' --description 'alias l exa --group-directories-first -a -l --icons'
  exa --group-directories-first -a -l --icons $argv;
end
