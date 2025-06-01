for f ($ZSH_PLUGINS/*/*.zsh(N)) source "$f"

source $ZDOTDIR/starship.zsh
source $ZDOTDIR/zoxide.zsh

alias cd="z"
alias cdi="zi"

alias vi="nvim"
alias vim="nvim"

alias cat="bat"

macchina

source $ZSH/oh-my-zsh.sh

alias ls="eza"
