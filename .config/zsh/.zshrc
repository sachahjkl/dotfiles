export ZSH="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"

ZSH_PLUGINS="$ZSH/plugins"

source "$ZSH/zshdefaults"
eval "$(starship init zsh)"

[ -f "$ZSH_PLUGINS/zsh-autosuggestions/zsh-autosuggestions.zsh" ] && source "$ZSH_PLUGINS/zsh-autosuggestions/zsh-autosuggestions.zsh"
[ -f "$ZSH_PLUGINS/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ] && source "$ZSH_PLUGINS/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
