export ZSH="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"
zstyle ':completion:*' rehash true
zstyle ':completion:*' menu select
zstyle ':completion::complete:*' gain-privileges 1
setopt COMPLETE_ALIASES
autoload -Uz compinit
compinit


ZSH_PLUGINS="$ZSH/plugins"

source "$ZSH/zshdefaults"
eval "$(starship init zsh)"

TRAPUSR1() { rehash }
# source "$ZSH/zsh_keys_reset"

[ -f "$ZSH_PLUGINS/zsh-autosuggestions/zsh-autosuggestions.zsh" ] && source "$ZSH_PLUGINS/zsh-autosuggestions/zsh-autosuggestions.zsh"
[ -f "$ZSH_PLUGINS/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ] && source "$ZSH_PLUGINS/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
