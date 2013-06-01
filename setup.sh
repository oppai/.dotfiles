#!/bin/bash

DOT_FILES=( .bash_profile .screenrc .vimrc .gvimrc .emacs)

:q#install neobundle
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

echo "Complete setup.sh"

