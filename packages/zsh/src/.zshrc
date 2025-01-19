ZSH=$OH_MY_ZSH_DIR

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
