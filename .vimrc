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
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/neosnippet'

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
NeoBundle 'scrooloose/syntastic'

NeoBundle 'kuniwak/vim-prove-syntax'

NeoBundle 'git://github.lo.mixi.jp/vim/vim-autoload_pages_controller'
NeoBundle 'git://github.lo.mixi.jp/vim/vim-find_branch_root'
NeoBundle 'git://github.lo.mixi.jp/vim/vim-load_test'

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
au BufNewFile,BufRead *.t,*.pl,*.pm  set nowrap tabstop=4 shiftwidth=4 expandtab

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
let g:indent_guides_auto_colors = 1
hi IndentGuidesOdd  ctermbg=red
hi IndentGuidesEven ctermbg=darkgray

let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_indent_levels =30
let g:indent_guides_guide_size = 1
let g:indent_guides_start_level = 2

"gfでジャンプ Ctrl+Oで戻る
NeoBundle 'https://github.com/y-uuki/perl-local-lib-path.vim', {
            \ 'autoload': {
            \   'filetypes': ['perl']
            \ }}

let g:perl_local_lib_path = '$HOME/mixi'
autocmd FileType perl PerlLocalLibPath

" 保存に合わせてcodereview.pl template-validatorを実行
augroup EditPerl
autocmd!
autocmd BufWritePost,FileWritePost *.{t,p[lm]} QuickRun mperl
autocmd BufWritePost,FileWritePost *.tmpl QuickRun mperl
augroup END

" mixi-prove 使う場合は：
augroup my_mixi_prove
    autocmd!
    autocmd BufNewFile,BufRead *.t set filetype=perl.mixi-prove
augroup END

" QuickRun
let g:quickrun_config = {}
" Vimproc で Quickrun
let g:quickrun_config['_'] = {
      \ 'runner': 'vimproc',
      \       "runner/vimproc/updatetime" : 100
      \ }
let g:quickrun_config.mperl = {
      \  'command' : 'codereview.pl',
      \  'outputter/buffer/split' : ':botright 8sp',
      \  }
let g:quickrun_config['useless-module'] = {
      \  'command' : 'useless-module',
      \  'outputter/buffer/split' : ':botright 8sp',
      \  }
let g:quickrun_config['mixi-prove'] = {
      \  'command' : 'mixi-prove',
      \  'outputter/buffer/filetype': 'prove-output',
      \  'outputter/buffer/split' : ':botright 15sp',
      \  'hook/shebang/enable': 0,
      \  }

noremap <Leader>rt :QuickRun mixi-prove<CR>
noremap <Leader>rm :QuickRun useless-module<CR>

vnoremap <Leader>ps :!./script/devel/package-sorter %<CR>

" Syntasticによるチェックを手動でおこなう
let g:syntastic_mode_map = { "mode": "passive",
      \ "active_filetypes": [],
      \ "passive_filetypes": ["perl"] }

" 3種のチェックツールをつかう
"   - perl: Syntaxのチェック
"   - perlcritic: SyntaxErrorではないが、ミスだと思われるコードのチェック
"   - podchecker: Perlのドキュメント「POD」のチェック
let g:syntastic_perl_checkers = ["perl", "perlcritic", "podchecker"]

" チェッカーに Perl を使う場合、任意のコードを実行される脆弱性があるので明示的に許可する必要がある
let g:syntastic_enable_perl_checker = 1

" Syntastic に Perl のモジュールパスを追加する（上3つはcartonプロジェクト用）
let g:syntastic_perl_lib_path = [
             \ "lib",
             \ "local/lib/perl5",
             \ "local/lib/perl5/x86_64-linux",
             \ "/usr/local/mixi-devtools/mixi-test/local/lib/perl5/x86_64-linux-thread-multi",
             \ "/usr/local/mixi-devtools/mixi-test/local/lib/perl5",
             \ "/home/hiroaki.murayama/mixi/lib",
             \ "/home/hiroaki.murayama/mixi/t/inc",
             \ "/home/hiroaki.murayama/mixi/t/lib",
             \ "/var/www/mixi/local/lib/perl5/x86_64-linux-thread-multi",
             \ "/var/www/mixi/local/lib/perl5",
             \ ]

" perlcritic のチェックの厳しさを5段階のうち、3「harsh」に設定する（好み。社内のはひとつ緩い4の「stern」）
" http://search.cpan.org/dist/Perl-Critic/bin/perlcritic#OPTIONS
let g:syntastic_perl_perlcritic_args = "--harsh"

" <Leader>sc でシンタックスのチェックをおこなう
nnoremap <silent> <Leader>sc :<C-u>SyntasticCheck<CR>

" <Leader>sr でシンタックスのチェック結果を隠す
nnoremap <silent> <Leader>sr :<C-u>SyntasticReset<CR>

" for snippets
imap <expr><C-k> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" : pumvisible() ? "\<C-n>" : "\<TAB>"
smap <C-k> <Plug>(neocomplcache_snippets_expand)

" Tell Neosnippet about the other snippets
let g:neosnippet#snippets_directory="~/.vim/snippets"


" For mixi
".tを縦分割した右側のウィンドウで開く場合
noremap <C-j> :call LoadTest('bel vne')<CR>
"".tを縦分割した左側のウィンドウで開く場合
"noremap <C-j> :call LoadTest('abo vne')<ENTER>
"".tを横分割した下側のウィンドウで開く場合
"noremap <C-j> :call LoadTest('bel sp')<ENTER>
"".tを横分割した上側のウィンドウで開く場合
"noremap <C-j> :call LoadTest('abo sp')<ENTERN>


