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
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimfiler.vim'

NeoBundle 'vim-scripts/hybrid.vim'
NeoBundle 'Lokaltog/vim-powerline'
NeoBundle 'tomasr/molokai'
NeoBundle 'Shougo/vimshell'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'nathanaelkane/vim-indent-guides'

NeoBundle 'evidens/vim-twig'
NeoBundle 'tpope/vim-surround'

NeoBundle 'Shougo/vimproc', {
      \ 'build' : {
      \     'windows' : 'make -f make_mingw32.mak',
      \     'cygwin' : 'make -f make_cygwin.mak',
      \     'mac' : 'make -f make_mac.mak',
      \     'unix' : 'make -f make_unix.mak',
      \    },
      \ }

NeoBundle 'scratch.vim'

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

set fileencodings=utf-8,iso-2022-jp,euc-jp,cp932,ucs-bom,default,latin1

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

" Vim indent gui
let g:indent_guides_auto_colors=0
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=3
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=4
let g:indent_guides_enable_on_vim_startup=1

NeoBundle 'https://github.com/y-uuki/perl-local-lib-path.vim', {
            \ 'autoload': {
            \   'filetypes': ['perl']
            \ }}

let g:perl_local_lib_path = '$HOME/mixi'
autocmd FileType perl PerlLocalLibPath

" 保存に合わせてcodereview.pl template-validatorを実行
augroup EditPerl
autocmd!
autocmd BufWritePost,FileWritePost QuickRun mperl
"autocmd!
"autocmd BufWritePost,FileWritePost *.{t,p[lm]} !/usr/local/mixi-devtools/mixi-codereview/bin/codereview.pl <afile>
"autocmd BufWritePost,FileWritePost *.tmpl !./script/devel/template-validator <afile>
augroup END

" QuickRun
let g:quickrun_config = {}
" Vimproc で Quickrun
let g:quickrun_config['_'] = {
      \ 'runner': 'vimproc',
      \       "runner/vimproc/updatetime" : 100
      \ }
let g:quickrun_config.mperl = {'command' : 'codereview.pl'}
let g:quickrun_config.mtmpl = {'command' : './script/devel/template-validator.pl'}

