export ZSH="/Users/kevinvelasquez/.oh-my-zsh"
ZSH_THEME=""
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

autoload -U promptinit; promptinit
prompt pure

alias tree="tree -CL 2"
alias vim="nvim"
