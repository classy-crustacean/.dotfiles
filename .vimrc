set nocompatible
call plug#begin()
Plug 'preservim/nerdtree'
Plug 'vim-python/python-syntax'
Plug 'vim-scripts/javacomplete'
Plug 'pprovost/vim-ps1'
Plug 'othree/xml.vim'
Plug 'rust-lang/rust.vim'
Plug 'dag/vim-fish'
call plug#end()
syntax enable
filetype plugin indent on
set number
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') |
			\ execute 'NERDTree' argv()[0] | endif
set shiftwidth=2
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
set nobackup
set noswapfile
autocmd filetype python set expandtab
nnoremap <F5> :w<ENTER>:!clear<ENTER>:!%:p<ENTER>
