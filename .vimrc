"Neobundle Setup
set nocompatible
filetype off
if has('vim_starting')
	set runtimepath+=~/.vim/neobundle.vim.git
	call neobundle#rc(expand('~/.bundle'))
endif

NeoBundle 'mattn/calendar-vim'
NeoBundle 'fuenor/qfixgrep'
NeoBundle 'vim-scripts/ShowMarks'
NeoBundle 'fuenor/qfixgrep'
NeoBundle 'tpope/vim-markdown'
NeoBundle 'Shougo/neocomplcache'

filetype plugin indent on

NeoBundleCheck

"Key Remap
vnoremap > >gv
vnoremap < <gv

"Basic setting
syntax on				"syntax highlight
set number			"line number
set autoindent	"auto indent
set noeol 			"no eol in EOF

set tabstop=2			" tabstop is 2 as space
set shiftwidth=2	" shift width is 2

set showmatch
set whichwrap=b,s,h,l,<,>,[,]
set smarttab

let g:neocomplcache_enable_at_startup = 1

"statusline
set laststatus=2
set statusline=%n\:%y
set statusline+=[%{(&fenc!=''?&fenc:&enc)}]
set statusline+=[%{Getff()}]
set statusline+=%m%r\ %F%=[%l/%L]

function! Getff()
	if &ff == 'unix'
		return 'LF'
	elseif &ff == 'dos'
		return 'CR+LF'
	elseif &ff == 'mac'
		return 'CR'
	else
		return '?'
	endif
endfunction

"GUI setting
if has('gui_macvim')
    set transparency=3
    set guifont=Menlo:h12
    set lines=90 columns=200
    set guioptions-=T
endif

"Load template files
augroup repltemplates
	autocmd!
	autocmd BufNewFile *.c 0r ~/.dotfiles/.vim/skelton.c
	autocmd BufNewFile *.php 0r ~/.dotfiles/.vim/skelton.php
	autocmd BufNewFile *.sh 0r ~/.dotfiles/.vim/skelton.sh
	autocmd BufNewFile *.cpp 0r ~/.dotfiles/.vim/skelton.cpp
augroup END

