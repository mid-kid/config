" Set plugins
call plug#begin('~/.vim/plugged')

" Install plugins (vim):
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim && vim +PlugInstall
" Install plugins (neovim):
" curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim && nvim +PlugInstall

" Faaancy
Plug 'junegunn/seoul256.vim'
Plug 'airblade/vim-gitgutter'
Plug 'Xuyuanp/nerdtree-git-plugin'

" Syntax
Plug 'rust-lang/rust.vim'
Plug 'cespare/vim-toml'
Plug 'Glench/Vim-Jinja2-Syntax'
Plug 'PotatoesMaster/i3-vim-syntax'
Plug 'lervag/vimtex'
Plug 'zah/nim.vim'

" Other
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'Raimondi/delimitMate'
Plug 'vim-scripts/AutoComplPop'
Plug 'embear/vim-localvimrc'
Plug 'tpope/vim-surround'

call plug#end()

" Color scheme
let g:seoul256_background = 233
colorscheme seoul256

" Syntax highlighting
filetype plugin indent on
syntax on

" Whitespace
set tabstop=4
set shiftwidth=4
set expandtab
set smarttab
set autoindent

" Display
set number
set hlsearch
set incsearch
set statusline=%f
set colorcolumn=80
match ExtraWhitespace /\s\+$/  " ExtraWhitespace is defined in the theme

" Behavior
set omnifunc=syntaxcomplete#Complete
set mouse=a
set ttyfast
set clipboard=unnamed
set clipboard+=unnamedplus
set nobackup
set noundofile

" Keybinds
let mapleader=";"
let maplocalleader=";"
map <F1> :make<CR>
map <F8> :!curl -T % chunk.io 2> /dev/null<CR>
map <F12> :syntax sync fromstart<CR>
map <F11> :SyntasticToggleMode<CR>
map <C-n> :noh<CR>

nnoremap <C-h> <C-w><C-h>
nnoremap <C-j> <C-w><C-j>
nnoremap <C-k> <C-w><C-k>
nnoremap <C-l> <C-w><C-l>

" NERDTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" NERDCommenter
let g:NERDAltDelims_c=1

" Localvimrc
let g:localvimrc_sandbox=0
let g:localvimrc_count=1
