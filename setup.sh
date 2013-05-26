#!/bin/bash

DOT_FILES=( .bash_profile .screenrc .vimrc )

#install neobundle
if [ ! -d ~/.vim/neobundle.vim.git ]; then
	git clone https://github.com/Shougo/neobundle.vim ~/.vim/neobundle.vim.git
fi

for file in ${DOT_FILES[@]}
do
    ln -s $HOME/.dotfiles/$file $HOME/$file
done

echo "Complete setup.sh"

