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

bt() {
  case "$1" in
    on)  bluetoothctl power on ;;
    off) bluetoothctl power off ;;
    *)   bluetoothctl "$@" ;;
  esac
}

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

# Git
gmsg-api() {
  emulate -L zsh

  local model="${OLLAMA_COMMIT_MODEL:-qwen2.5-coder:1.5b}"

  git rev-parse --is-inside-work-tree >/dev/null 2>&1 || {
    print -u2 -- "Not inside a git repo"
    return 1
  }

  git diff --cached --quiet && {
    print -u2 -- "No staged changes. Use: git add <files>"
    return 1
  }

  local diff examples prompt
  diff="$(git diff --cached)"

  examples="$(git log --pretty=format:'- %s' -n 20 2>/dev/null)"

  prompt="Write exactly one git commit message for this staged git diff.

Use the same style, wording, capitalization, and format as these recent commits:

$examples

Rules:
- Output only the commit message.
- No markdown.
- No code fences.
- No quotes.
- No explanation.
- Keep it concise.
- Match the project's existing commit style over Conventional Commits if they differ.

Example output:
fix: resolve null pointer in user auth flow

Staged diff:
$diff"

  jq -n \
    --arg model "$model" \
    --arg prompt "$prompt" \
    '{
      model: $model,
      prompt: $prompt,
      stream: false,
      options: {
        temperature: 0.2,
        num_ctx: 8192
      }
    }' |
    curl -s http://localhost:11434/api/generate -d @- |
    jq -r '.response' |
    sed '/^[[:space:]]*$/d' |
    head -n 1
}
