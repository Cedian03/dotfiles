export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="eastwood"
HYPHEN_INSENSITIVE="true"

# git clone --depth 1 https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
# git clone --depth 1 https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
# git clone --depth 1 https://github.com/Cedian03/zsh-pathstash ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/pathstash
plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
  pathstash
)

source $ZSH/oh-my-zsh.sh
autoload -U compinit && compinit

export EDITOR="nvim"
export PATH="$HOME/.opencode/bin:$PATH"

eval "$(zoxide init zsh --cmd cd)"

# Bat
if command -v batcat >/dev/null 2>&1 && ! command -v bat >/dev/null 2>&1; then
  alias bat="batcat"
fi
command -v bat >/dev/null 2>&1 && help() { "$@" --help 2>&1 | bat --plain --language=help; }

RPROMPT='%{$fg[cyan]%}${SSH_CONNECTION:+%n@%m}%{$reset_color%}'

# Aliases
alias s="pacman -Ss"
alias i="sudo pacman -S"
alias r="sudo pacman -Rns"
alias oc="opencode"
alias cx="codex"
alias t='tmux attach || tmux new -s Work'

# Pathstash
bindkey "^Xf" pathstash-fill

# Tmux dev layout
tdl() {
  [[ -z $1 ]] && { echo "Usage: tdl <agent>"; return 1 }
  [[ -z $TMUX ]] && { echo "You must be inside tmux to use tdl."; return 1 }

  local current_dir="${PWD}"
  local editor_pane="${TMUX_PANE}"
  local agent="$1"

  tmux rename-window "$(basename "$current_dir")"
  tmux split-window -v -p 20 -c "$current_dir"

  local agent_pane
  agent_pane=$(tmux split-window -h -p 40 -t "$editor_pane" -c "$current_dir" -P -F '#{pane_id}')

  tmux send-keys -t "$agent_pane" "$agent" C-m
  tmux send-keys -t "$editor_pane" "$EDITOR ." C-m
  tmux select-pane -t "$editor_pane"
}

alias ic='tdl opencode'
alias ix='tdl codex'
