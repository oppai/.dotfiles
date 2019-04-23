# export
export PATH=/usr/local/bin:$PATH
export PATH=/usr/local/sbin:$PATH

if [ `test -x go` ];then
  export GOROOT=`go env GOROOT`
  export GOPATH=$HOME/go
  export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
fi

# alias
alias ls='ls -F'
alias ll='ls -al'
alias la='ls -a'
alias lla='ls -la'

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

function kube_ctx  {
  kubectl config current-context
}

function get_face_status {
  if [[ "$?" == "0" ]]; then
    echo '(๑´ڡ`๑)'
    return;
  fi
  echo '%F{red}(* ~ *)%f'
}

PROMPT='[%F{yellow}%~|%F{green}%B%n%b%f]$ '
RPROMPT='$(get_face_status) %F{cyan}$(kube_ctx) %1(v|%F{gray}%1v%f|) %F{magenta}%m'

setopt prompt_subst


# alias
alias chrome='open -a /Applications/Google\ Chrome.app/'
alias code='open -a /Applications/Visual\ Studio\ Code.app/'
alias gvim='open -a /Applications/MacVim.app/'
alias t="tmux"
alias v="vim"
alias g="git"
alias gg="git graph"
alias vi=vim

alias git-diff-name="git diff --name-only"
alias -g C='`git rev-parse --abbrev-ref HEAD`'
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
SOCK="/tmp/ssh-agent-$USER-screen"
if test $SSH_AUTH_SOCK && [ $SSH_AUTH_SOCK != $SOCK ]
then
    ln -sf $SSH_AUTH_SOCK $SOCK
    export SSH_AUTH_SOCK=$SOCK
fi

fixssh() {
  for key in SSH_AUTH_SOCK SSH_CONNECTION SSH_CLIENT; do
    if (tmux show-environment | grep "^${key}" > /dev/null); then
      value=`tmux show-environment | grep "^${key}" | sed -e "s/^[A-Z_]*=//"`
      export ${key}="${value}"
    fi
  done
}

# git-complete
fpath=(~/.zsh/completion $fpath)

npmbin(){[ $# -ne 0 ] && $(npm bin)/$*}

# For Elixir/Erlang
export ERL_AFLAGS="-kernel shell_history enabled"

###### END FOR COMMON SETTING

