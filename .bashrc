export CLICOLOR=1
export LSCOLORS=DxGxcxdxCxegedabagacada

# define colors
C_DEFAULT="\[\033[m\]"
C_WHITE="\[\033[1m\]"
C_BLACK="\[\033[30m\]"
C_RED="\[\033[31m\]"
C_GREEN="\[\033[32m\]"
C_YELLOW="\[\033[33m\]"
C_BLUE="\[\033[34m\]"
C_PURPLE="\[\033[35m\]"
C_CYAN="\[\033[36m\]"
C_LIGHTGRAY="\[\033[37m\]"
C_DARKGRAY="\[\033[1;30m\]"
C_LIGHTRED="\[\033[1;31m\]"
C_LIGHTGREEN="\[\033[1;32m\]"
C_LIGHTYELLOW="\[\033[1;33m\]"
C_LIGHTBLUE="\[\033[1;34m\]"
C_LIGHTPURPLE="\[\033[1;35m\]"
C_LIGHTCYAN="\[\033[1;36m\]"
C_BG_BLACK="\[\033[40m\]"
C_BG_RED="\[\033[41m\]"
C_BG_GREEN="\[\033[42m\]"
C_BG_YELLOW="\[\033[43m\]"
C_BG_BLUE="\[\033[44m\]"
C_BG_PURPLE="\[\033[45m\]"
C_BG_CYAN="\[\033[46m\]"
C_BG_LIGHTGRAY="\[\033[47m\]"

# Prompt
kodam="kodam"
export PS1="$C_LIGHTGREEN\h$C_DARKGRAY:$C_LIGHTYELLOW\W $C_LIGHTPURPLE\u$C_DEFAULT\$"

if [ -d /Applications/Sublime\ Text.app/ ]; then
  alias sublime='open -a "/Applications/Sublime Text.app/"';
fi
if [ -d /Applications/Sublime\ Text\ 2.app/ ]; then
  alias sublime='open -a "/Applications/Sublime Text 2.app/"';
fi

alias chrome='open -a /Applications/Google\ Chrome.app/'
alias gvim='open -a /Applications/MacVim.app/'
alias sc="screen -s bash"
alias t="tmux"
alias v="vim"
alias g="git"
alias gg="git graph"
alias gd="git diff"
alias s="git status --short --branch"

# screen -xR

export PATH=/usr/local/bin:$PATH


[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
export PATH="$HOME/.plenv/bin:$PATH"
if [ -f plenv ]; then
  eval "$(plenv init -)"
fi

export PATH=$PATH:/usr/local/go/bin

# git-complete
source $HOME/.git-completion.bash


