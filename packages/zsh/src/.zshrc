for f ($ZSH_PLUGINS/*/*.zsh(N)) source "$f"

eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

alias cd="z"
alias cdi="zi"

alias vi="nvim"
alias vim="nvim"

alias cat="bat"

macchina

source $ZSH/oh-my-zsh.sh
