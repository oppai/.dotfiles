"Neobundle Setup
set nocompatible
filetype off
if has('vim_starting')
	set runtimepath+=~/.vim/neobundle.vim.git
endif

call neobundle#rc(expand('~/.bundle'))

NeoBundle 'mattn/calendar-vim'
NeoBundle 'fuenor/qfixgrep'
NeoBundle 'vim-scripts/ShowMarks'
NeoBundle 'fuenor/qfixgrep'
NeoBundle 'tpope/vim-markdown'
NeoBundle 'Shougo/neocomplcache'

NeoBundle 'vim-scripts/hybrid.vim'

filetype plugin indent on

NeoBundleCheck


"Basic key Remap
noremap j gj
noremap k gk
noremap gk k
noremap gj j
noremap <Down> gj
noremap <Up> gk
vnoremap > >gv
vnoremap < <gv


" edit vimrc
let mapleader = ','
nnoremap <Leader>ev :tabnew $HOME/.vimrc<CR>
nnoremap <Leader>rv :source $HOME/.vimrc<CR>

" editting setting
syntax on
set autoindent
set number
set cursorline

set list
set listchars=eol:¬,tab:▸\ 

" tab setting
set tabstop=2
set shiftwidth=2
set scrolloff=20

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
if has('gui_running')
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

