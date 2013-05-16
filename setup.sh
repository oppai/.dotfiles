#!/bin/bash

DOT_FILES=( .bash_profile .screenrc .vimrc )

for file in ${DOT_FILES[@]}
do
    ln -s $HOME/.dotfiles/$file $HOME/$file
done

echo "Complete setup.sh
