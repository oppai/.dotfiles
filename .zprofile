# export

source ~/.zshrc

export PATH=/usr/local/bin:$PATH
export PATH=/usr/local/sbin:$PATH

export PATH=$PATH:/usr/local/go/bin

export GOROOT=$HOME/go
export GOPATH=$GOROOT/src:$GOROOT/bin
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

export CLICOLOR=1
export LSCOLORS=DxGxcxdxCxegedabagacad

# alias
alias ls='ls -F'
alias ll='ls -al'
alias la='ls -a'
alias lla='ls -la'
alias -g C='| pbcopy '
alias java='java -Dfile.encoding=UTF-8'

# autoload
autoload -U compinit
compinit

# history
HISTFILE=$HOME/.zsh-history
HISTSIZE=100000
SAVEHIST=100000
setopt hist_ignore_dups   #同じコマンドラインを連続で実行した場合はヒストリに登録しない
setopt hist_ignore_space  #スペースで始まるコマンドラインはヒストリに追加しない
setopt inc_append_history #すぐにヒストリファイルに追記する
setopt share_history      #zshプロセス間でヒストリを共有する

# git
autoload -Uz vcs_info
zstyle ':vcs_info:*' formats '[%b]'
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd () {
    psvar=()
    LANG=en_US.UTF-8 vcs_info
    [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}

PROMPT="[%F{yellow}%~|%F{green}%B%n%b%f]$"
RPROMPT="%1(v|%F{white}%1v%f|)"

# alias
alias chrome='open -a /Applications/Google\ Chrome.app/'
alias gvim='open -a /Applications/MacVim.app/'
alias sc="screen -s bash"
alias t="tmux"
alias v="vim"
alias g="git"
alias gg="git graph"

alias s="git status --short --branch"
alias gr="git reset"
alias gd="git diff"
alias gdc="git diff --cached"
alias ga="git add"
alias co="git checkout"
alias gname="git diff --name-only"
alias ghead="git rev-parse --abbrev-ref HEAD"
alias tigs="tig status"

# セパレータを設定する
zstyle ':completion:*' list-separator '-->'
zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# Color
export CLICOLOR=1
export LSCOLORS=DxGxcxdxCxegedabagacada

# ファイル補完に色を付ける
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}¬

# http://qiita.com/items/13d150c590508d518d26
autoload -U compinit
compinit
zstyle ':completion:*:default' menu select=1
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# ssh-agent
eval `/usr/bin/ssh-agent`

# git-complete
fpath=(~/.zsh/completion $fpath)

# tmuxinator
# source ~/.bin/tmuxinator.zsh

