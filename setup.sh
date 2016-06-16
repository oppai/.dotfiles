#!/bin/bash

DOT_FILES=( .bash_profile .gitconfig .screenrc .vimrc .gvimrc .xvimrc .emacs .git-completion.bash
            .tmux.conf .gvimrc .zprofile .gitignore)

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

#Install diff-highlight
if [ ! -x "`which diff-highlight`" ]; then
  curl -s https://raw.githubusercontent.com/git/git/master/contrib/diff-highlight/diff-highlight > diff-highlight
  chmod +x ./diff-highlight
  echo "Install diff-highlight in /usr/local/bin/ ?"
  sudo mv ./diff-highlight /usr/local/bin/
fi

echo "Complete setup.sh"

