#!/bin/bash

DOT_FILES=( .bash_profile .gitconfig .screenrc .vimrc .gvimrc .xvimrc .emacs .git-completion.bash
            .tmux.conf .gvimrc .zprofile .gitignore)

#install neobundle
if [ ! -d ~/.vim/neobundle.vim.git ]; then
	git clone https://github.com/Shougo/neobundle.vim ~/.vim/neobundle.vim.git
fi

#copy vim script for dont use neobundle
for file in `ls ~/.dotfiles.mixi/.vim/plugin/`;
do
	ln -s ~/{.dotfiles.mixi/,}.vim/plugin/$file;
done

#copy dotfiles
for file in ${DOT_FILES[@]};
do
    ln -s $HOME/.dotfiles.mixi/$file $HOME/$file;
done

echo "Complete setup.sh"

