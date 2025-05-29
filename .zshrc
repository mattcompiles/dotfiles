# Setup zinit plugin manager
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"

source "${ZINIT_HOME}/zinit.zsh"

zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Load zsh-completions
autoload -U compinit && compinit

zstyle ':completion:*' menu no

bindkey -v

bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

# History
HISTSIZE=5000
HISTFILE=${ZINIT_HOME}/.zsh_history
SAVEHIST=$HISTSIZE HISTDIP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

source "${HOME}/.zsh-prompt"
source "${HOME}/.aliases"
source "${HOME}/.afm-git-configrc"

eval "$(zoxide init zsh --cmd cd)"
eval "$(fzf --zsh)"
eval "$(fnm env --use-on-cd)"

if [[ $(uname) == "Darwin" ]]; then
  source "${HOME}/.zsh-mac"
fi

export PATH="/Users/mjones4/.local/bin:$PATH"
export EDITOR="$(which nvim)"

export APVM_ATLASPACK_LOCAL="$HOME/atlassian/atlaspack"
