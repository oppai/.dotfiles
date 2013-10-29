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
NeoBundle 'tpope/vim-markdown'
NeoBundle 'Shougo/neocomplcache'

NeoBundle 'vim-scripts/hybrid.vim'
NeoBundle 'Lokaltog/vim-powerline'
NeoBundle 'tomasr/molokai'
NeoBundle 'Shougo/vimshell'
NeoBundle 'Shougo/vimproc'
NeoBundle 'thinca/vim-quickrun'

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


"Edit vimrc
let mapleader = ','
nnoremap <Leader>ev :tabnew $HOME/.vimrc<CR>
nnoremap <Leader>rv :source $HOME/.vimrc<CR>

"Editting setting
syntax on
set autoindent
set number
set cursorline
set nowrap

"Color
set t_Co=256

set list
set listchars=eol:¬,tab:▸\ 

"insertモードを抜けるとIMEオフ
set noimdisable
set iminsert=0 imsearch=0
set noimcmdline
inoremap :set iminsert=0

"Tab setting
set tabstop=2
set shiftwidth=2
set expandtab
set scrolloff=20

set showmatch
set whichwrap=b,s,h,l,<,>,[,]
set smarttab

"For Perl
au BufNewFile,BufRead *.pl,*.pm  set nowrap tabstop=4 shiftwidth=4 expandtab

let g:neocomplcache_enable_at_startup = 1

"Statusline
set laststatus=2
set statusline=%n\:%y
set statusline+=[%{(&fenc!=''?&fenc:&enc)}]
set statusline+=[%{Getff()}]
set statusline+=%m%r\ %F%=[%l/%L]

"Color scheme
colorscheme molokai

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
	autocmd BufNewFile *.pl 0r ~/.dotfiles/.vim/skelton.pl
augroup END

" commentout.vim
" lhs comments
vmap ,# :s/^/#/<CR>:nohlsearch<CR>
vmap ,/ :s/^/\/\//<CR>:nohlsearch<CR>
vmap ,> :s/^/> /<CR>:nohlsearch<CR>
vmap ," :s/^/\"/<CR>:nohlsearch<CR>
vmap ,% :s/^/%/<CR>:nohlsearch<CR>
vmap ,! :s/^/!/<CR>:nohlsearch<CR>
vmap ,; :s/^/;/<CR>:nohlsearch<CR>
vmap ,- :s/^/--/<CR>:nohlsearch<CR>
vmap ,c :s/^\/\/\\|^--\\|^> \\|^[#"%!;]//<CR>:nohlsearch<CR>

" wrapping comments
vmap ,* :s/^\(.*\)$/\/\* \1 \*\//<CR>:nohlsearch<CR>
vmap ,( :s/^\(.*\)$/\(\* \1 \*\)/<CR>:nohlsearch<CR>
vmap ,< :s/^\(.*\)$/<!-- \1 -->/<CR>:nohlsearch<CR>
vmap ,d :s/^\([/(]\*\\|<!--\) \(.*\) \(\*[/)]\\|-->\)$/\2/<CR>:nohlsearch<CR>

" block comments
vmap ,b v`<I<CR><esc>k0i/*<ESC>`>j0i*/<CR><esc><ESC>
vmap ,h v`<I<CR><esc>k0i<!--<ESC>`>j0i--><CR><esc><ESC>

