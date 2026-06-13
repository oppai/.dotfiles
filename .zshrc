# export
export PATH=/usr/local/bin:$PATH
export PATH=/usr/local/sbin:$PATH

# alias
alias ls='ls -F'
alias ll='ls -al'

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
  # kubectl config current-context
}

function get_face_status {
  local exit_code=$?
  if [[ "$exit_code" == "0" ]]; then
    echo '(๑´ڡ`๑)'
    return;
  fi
  echo '%F{red}(* ~ *)%f'
}

PROMPT='[%F{yellow}%~|%F{green}%B%n%b%f]$ '
RPROMPT='$(get_face_status) %F{cyan} %1(v|%F{gray}%1v%f|)'

setopt prompt_subst


# alias
alias chrome='open -a /Applications/Google\ Chrome.app/'
alias gvim='open -a /Applications/MacVim.app/'
alias t="tmux"
alias v="vim"
alias g="git"
alias gg="git graph"
alias vi=vim

alias git-diff-name="git diff --name-only"
alias -g C='`git rev-parse --abbrev-ref HEAD`'
alias tigs="tig status"

alias k=kubectl
alias kg="k get"
alias kp="k get pod"
alias kl="k logs"
alias tf=terraform

# セパレータを設定する
zstyle ':completion:*' list-separator '-->'
zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# Color
export CLICOLOR=1
export LSCOLORS=DxGxcxdxCxegedabagacad

# ファイル補完に色を付ける
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}¬

# git-complete (must be before compinit for completion to work)
fpath=(~/.zsh/completion $fpath)

# http://qiita.com/items/13d150c590508d518d26
autoload -U compinit
compinit
zstyle ':completion:*:default' menu select=1
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# Google Cloud SDK (load right after compinit to avoid double compinit)
if [ -f "$HOME/bin/google-cloud-sdk/path.zsh.inc" ]; then . "$HOME/bin/google-cloud-sdk/path.zsh.inc"; fi
if [ -f "$HOME/bin/google-cloud-sdk/completion.zsh.inc" ]; then . "$HOME/bin/google-cloud-sdk/completion.zsh.inc"; fi

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

npmbin(){[ $# -ne 0 ] && $(npm bin)/$*}

git() {
  local cmd=$1
  if [[ $cmd == "push" ]]; then
    # for force-push
    if [[ $4 == "master" || $4 == "main" || $4 == "develop" ]]; then
      echo "Don't force push to master/main/develop"
      return 1
    # for no-option
    elif [[ $3 == "master" || $3 == "main" || $3 == "develop" ]]; then
      echo "Don't push to master/main/develop"
      return 1
    fi
  fi
  /usr/bin/git $@
}
alias git-force=/opt/homebrew/bin/git

kube_set_namespace() {
  kubectl config set-context $(kubectl config current-context) --namespace=${1}
}

pt() {
  /usr/local/bin/pt --hidden $@
}

# k8s config (use cached completion to avoid slow startup)
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

# For Elixir/Erlang
export ERL_AFLAGS="-kernel shell_history enabled"

###### END FOR COMMON SETTING

