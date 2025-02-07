source $ZSH

 plugins=(
  zsh-autosuggestions
  fast-syntax-highlighting
  zsh-autocomplete
 )

eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

alias cd="z"
alias cdi="zi"

alias vi="nvim"
alias vim="nvim"

macchina
