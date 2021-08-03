set nocompatible
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
syntax enable
filetype plugin indent on
set number
autocmd StdinReadPre * let s:std_in=1
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
set noswapfile
set backupdir-=.
set backupdir^=~/tmp,/tmp
autocmd filetype python set expandtab
nnoremap <F5> :w<ENTER>:!clear<ENTER>:!%:p<ENTER>
nnoremap <Leader>f :NERDTreeToggle<Enter>
nnoremap <Leader>w <C-w><C-w>
let g:NERDTreeGitStatusConcealBrackets = 1
