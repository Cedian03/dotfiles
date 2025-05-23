export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="clean"

HYPHEN_INSENSITIVE="true"

plugins=(git rust)

source $ZSH/oh-my-zsh.sh

autoload -U compinit && compinit

eval "$(zoxide init zsh --cmd cd)"