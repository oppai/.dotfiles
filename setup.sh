#!/bin/bash
IS_MACOS=$(if type "sw_vers" > /dev/null 2>&1; then echo "true";fi)
DOT_FILES=( .bashrc .gitconfig .screenrc .vimrc .gvimrc .xvimrc .emacs .git-completion.bash
            .tmux.conf .gvimrc .zshrc .gitignore)

#install neobundle
if [ ! -d ~/.vim/neobundle.vim.git ]; then
	git clone https://github.com/Shougo/neobundle.vim ~/.vim/neobundle.vim.git
fi

#copy vim script for dont use neobundle
for file in `ls ~/.dotfiles/.vim/plugin/`;
do
	ln -s ~/{.dotfiles/,}.vim/plugin/$file;
done

#copy dotfiles
for file in ${DOT_FILES[@]};
do
    ln -s $HOME/.dotfiles/$file $HOME/$file;
done

#install tmux plugin
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

#Install Mac brew
if ! type "brew" > /dev/null 2>&1 ; then
  if [ "$IS_MACOS" -eq "true" ]; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
  fi
fi

#Install diff-highlight
if ! type "diff-highlight" > /dev/null 2>&1 ; then
  brew install git
  ln -s /usr/local/share/git-core/contrib/diff-highlight/diff-highlight /usr/local/bin/diff-highlight
fi
echo "Complete setup.sh"

