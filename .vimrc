"Neobundle Setup
set nocompatible
filetype off
if has('vim_starting')
  set runtimepath+=~/.vim/neobundle.vim.git
	call neobundle#rc(expand('~/.bundle'))
endif

NeoBundle 'mattn/calendar-vim'

filetype plugin indent on

NeoBundleCheck

syntax on				"syntax highlight
set number			"line number
set autoindent	"auto indent
set noeol 			"no eol in EOF

set tabstop=2			" tabstop is 2 as space
set shiftwidth=2	" shift width is 2

set showmatch
set whichwrap=b,s,h,l,<,>,[,]
set smarttab

"Load template files
augroup repltemplates
	autocmd!
	autocmd BufNewFile *.c 0r ~/.dotfiles/.vim/skelton.c
	autocmd BufNewFile *.php 0r ~/.dotfiles/.vim/skelton.php
	autocmd BufNewFile *.sh 0r ~/.dotfiles/.vim/skelton.sh
	autocmd BufNewFile *.cpp 0r ~/.dotfiles/.vim/skelton.cpp
augroup END

