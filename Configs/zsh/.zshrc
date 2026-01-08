export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="eastwood"

HYPHEN_INSENSITIVE="true"

plugins=(git rust)

source $ZSH/oh-my-zsh.sh

autoload -U compinit && compinit

eval "$(zoxide init zsh --cmd cd)"

if command -v batcat >/dev/null 2>&1 && ! command -v bat >/dev/null 2>&1; then
  alias bat="batcat"
fi

if command -v bat >/dev/null 2>&1; then
    alias bathelp="bat --plain --language=help"
    
    alias -g -- -h="-h 2>&1 | bathelp"
    alias -g -- --help="--help 2>&1 | bathelp"
fi