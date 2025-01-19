source $ZSH

 plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
  fast-syntax-highlighting
  zsh-autocomplete
 )

eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

alias cd="z"
alias cdi="zi"

fastfetch
