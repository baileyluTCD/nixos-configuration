for file in $ZSH_CUSTOM/plugins/*/*.zsh; do
  source "$file"
done

eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

alias cd="z"
alias cdi="zi"

alias vi="nvim"
alias vim="nvim"

macchina

source $ZSH/oh-my-zsh.sh
