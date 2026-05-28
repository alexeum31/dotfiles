PROMPT='%d %# '
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.npm-global/bin:$PATH"

# save history
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory
setopt incappendhistory

# alias
alias v="nvim"

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
