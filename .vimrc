"Neobundle Setup
set nocompatible
filetype off
if has('vim_starting')
	set runtimepath+=~/.vim/neobundle.vim.git
endif

" Go lang
set rtp+=$GOROOT/misc/vim
exe "set rtp+=".globpath($GOPATH, "src/github.com/nsf/gocode/vim")
set completeopt=menu,preview
if $GOROOT != ''
  set rtp+=$GOROOT/misc/vim
endif

call neobundle#rc(expand('~/.bundle'))

NeoBundle 'mattn/calendar-vim'
NeoBundle 'fuenor/qfixgrep'
NeoBundle 'tpope/vim-markdown'
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimfiler.vim'
NeoBundle 'Shougo/neosnippet'

NeoBundle 'vim-scripts/hybrid.vim'
NeoBundle 'Lokaltog/vim-powerline'
NeoBundle 'Shougo/vimshell'
NeoBundle 'Shougo/vimproc.vim',{
      \ 'build' : {
      \     'cygwin' : 'make -f make_cygwin.mak',
      \     'mac' : 'make -f make_mac.mak',
      \     'unix' : 'make -f make_unix.mak',
      \    },
      \ }
NeoBundle 'thinca/vim-quickrun'

NeoBundle 'scratch.vim'
NeoBundle 'nathanaelkane/vim-indent-guides'
NeoBundle 'tpope/vim-surround'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimfiler.vim'

NeoBundle 'tomasr/molokai'
NeoBundle 'evidens/vim-twig'
NeoBundle 'tpope/vim-surround'
NeoBundle 'alpaca-tc/neorspec.vim', { 'depends' : 'tpope/vim-rails' }
NeoBundle 'scrooloose/syntastic'
NeoBundle 'Shougo/vimfiler.vim'
NeoBundle 'mattn/sonictemplate-vim'

NeoBundle 'Shougo/vimproc', {
      \ 'build' : {
      \     'windows' : 'make -f make_mingw32.mak',
      \     'cygwin' : 'make -f make_cygwin.mak',
      \     'mac' : 'make -f make_mac.mak',
      \     'unix' : 'make -f make_unix.mak',
      \    },
      \ }

NeoBundle 'scratch.vim'
NeoBundle 'scrooloose/syntastic'

NeoBundle 'kuniwak/vim-prove-syntax'

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

nnoremap <ESC><ESC> :set hlsearch!<CR>
set fileencodings=utf-8,iso-2022-jp,euc-jp,cp932,ucs-bom,default,latin1

"Color
set t_Co=256
set hlsearch
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
set wildmenu

set fileencodings=utf-8,iso-2022-jp,euc-jp,cp932,ucs-bom,default,latin1

set wildmenu

"For Perl
au BufNewFile,BufRead *.t,*.pl,*.pm,*.tmpl  set nowrap tabstop=4 shiftwidth=4 expandtab
"For Go
au BufNewFile,BufRead *.go  set nowrap tabstop=2 shiftwidth=2 noexpandtab
"For JS
au BufNewFile,BufRead *.js  set nowrap tabstop=4 shiftwidth=4 expandtab

"neocomplcache
"let g:neocomplcache_enable_at_startup = 1
"let g:neocomplcache_enable_camel_case_completion = 0

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
" indent-guides を有効にする
autocmd VimEnter * :IndentGuidesEnable

" 1インデント目からガイドする
let g:indent_guides_start_level = &tabstop

" 自動カラーを無効にして手動で設定する
let g:indent_guides_auto_colors = 0

" 奇数インデントのガイドカラー
"hi IndentGuidesOdd  ctermbg=lightgrey

" 偶数インデントのガイドカラー
hi IndentGuidesOdd  ctermbg=darkgray

" 偶数インデントのガイドカラー
"hi IndentGuidesEven ctermbg=black

" ハイライト色の変化の幅 (Terminal では未サポート)
"let g:indent_guides_color_change_percent = 20
" ガイドの幅
let g:indent_guides_guide_size = 1

" for snippets
"imap <expr><C-k> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" : pumvisible() ? "\<C-n>" : "\<TAB>"
"smap <C-k> <Plug>(neocomplcache_snippets_expand)

" Tell Neosnippet about the other snippets
let g:neosnippet#snippets_directory="~/.vim/snippets"

" ガイド幅をインデント幅に合わせる
"let g:indent_guides_guide_size = &tabstop

" QuickRun
let g:quickrun_config = {}
" すべてのファイルタイプで vimproc をつかってコマンドを実行
let g:quickrun_config['_'] = {
      \ 'runner': 'vimproc',
      \ 'outputter/buffer/split' : ':botright',
      \ 'runner/vimproc/updatetime' : 100
      \ }
" 通常の rspec 用の設定
let g:quickrun_config['ruby.rspec'] = {
      \ 'command': 'bundle',
      \ 'cmdopt': 'exec rspec',
      \ }

" 新規ファイル/開くファイルの名前が ~_spec.rb のとき、ファイルタイプを ruby.rspec にする
augroup my_rspec
  autocmd!
  autocmd BufEnter *_spec.rb set filetype=ruby.rspec
augroup END

" normal モードのとき <Leader>r で QuickRun を実行（rspec の場合はテストを実行）
nnoremap <Leader>r :<C-u>QuickRun<CR>

" neorspec 用の設定関数を定義
function! s:load_neorspec_settings()
  " ~_spec.rb という名前のファイルを開いたとき、拡張子を ruby.rspec にする
  set filetype=ruby.rspec
  " normal モードのとき、<Leader>rc で現在の行の specを 実行
  nnoremap <buffer><Leader>rc :<C-U>RSpecCurrent<CR>
  " normal モードのとき、<Leader>rn で現在の行の最寄りの specを 実行
  nnoremap <buffer><Leader>rn :<C-U>RSpecNearest<CR>
  " normal モードのとき、<Leader>rn で全ての specを 実行
  nnoremap <buffer><Leader>ra :<C-U>RSpecAll<CR>
endfunction

" neorspec 用の autocmd を定義
augroup my_neorspec
  autocmd!
  " ~_spec.rb という名前のファイルを開いたとき、neorspec 用の設定を読み込む
  autocmd BufEnter *_spec.rb call s:load_neorspec_settings()
augroup END

" neorspec で実行するコマンドを QuickRun にする（その際、ruby.neorspec という
" ファイルタイプの設定を使って実行する）
let g:neorspec_command = 'QuickRun ruby.neorspec'

" neorspec 用の QuickRun の設定（neorspec が生成する tempfile を使う）
let g:quickrun_config['ruby.neorspec'] = {
      \ 'command': 'bundle',
      \ 'cmdopt': 'exec rspec',
      \ 'tempfile': '{spec}',
      \ }

" ファイルの保存時に Rubocop でコーディングルールチェック
let g:syntastic_mode_map = { 'mode': 'passive',
      \ 'active_filetypes': ['ruby'],
      \ 'passive_filetypes': [] }

" Syntastic が呼び出す Ruby のチェッカーを Rubocop に設定
let g:syntastic_ruby_checkers = ['rubocop']

let g:syntastic_auto_loc_list = 1
let g:syntastic_loc_list_height = 5

" normal モードのとき、<Leader>sc でコーディングルールをチェック
nnoremap <silent> <Leader>sc :<C-u>SyntasticCheck<CR>
" normal モードのとき、<Leader>st でコーディングルールのチェック/非チェックを
" 切り替え
nnoremap <silent> <Leader>st :<C-u>SyntasticToggleMode<CR>

