set nocompatible
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin()
Plug 'preservim/nerdtree'
Plug 'vim-python/python-syntax'
Plug 'vim-scripts/javacomplete'
Plug 'pprovost/vim-ps1'
Plug 'othree/xml.vim'
Plug 'rust-lang/rust.vim'
Plug 'dag/vim-fish'
Plug 'Xuyuanp/nerdtree-git-plugin'
call plug#end()
syntax on 
filetype plugin indent on
set number
set relativenumber
autocmd StdinReadPre * let s:std_in=1
":set autoindent
":set smartindent
set tabstop=4
set backspace=indent,eol,start
set autoindent
set shiftwidth=4
set showmatch
set ignorecase
set hlsearch
set incsearch
set noswapfile
set backupdir-=.
set backupdir^=~/tmp,/tmp
set belloff=all
nnoremap <F5> :w<ENTER>:!clear; ./%<ENTER>
nnoremap <Leader>f :NERDTreeToggle<Enter>
nnoremap <Leader>w <C-w><C-w>
let g:NERDTreeGitStatusConcealBrackets = 1

" filetypes
autocmd filetype c set tabstop=2 | set shiftwidth=2 | set expandtab | nnoremap <F5> :w<ENTER>:!clear;gcc -lm %;./a.out<ENTER>
autocmd filetype python set expandtab | nnoremap <F5> :w<ENTER>:!clear;python3 %<ENTER>
autocmd filetype sh nnoremap <F5> :w<ENTER>:!clear;sh %<ENTER>
