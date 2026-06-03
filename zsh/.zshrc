PROMPT='%d %# '
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.npm-global/bin:$PATH"
export PERF_SRC="/home/alexeum/src/linux/tools/perf"
# save history
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory
setopt incappendhistory

# alias
alias v="nvim"
alias ls="eza"
alias ll="eza -la"
alias perf="$PERF_SRC/perf"

# keybinds
bindkey "^[[1;5C" forward-word   # ctrl+right
bindkey "^[[1;5D" backward-word  # ctrl+left

# vim keybinds
bindkey -v

# install
[ -s "$HOME/.scm_breeze/scm_breeze.sh" ] && source "$HOME/.scm_breeze/scm_breeze.sh"

# plugins
source ~/.dotfiles/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.dotfiles/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
