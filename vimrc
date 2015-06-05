set nocompatible
filetype off

" Set plugins
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Install plugins:
" mkdir -p ~/.vim/bindle && git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim && vim +PluginInstall

" https://github.com/Shougo/neobundle.vim supports SVN, and may support other
"   sources in the future, such as compressed files. Maybe switch.
" Otherwise, https://github.com/MarcWeber/vim-addon-manager also looks nice,
"   but it lacks documentation.

" Vundle
Plugin 'gmarik/Vundle.vim'

" Color scheme
Plugin 'nanotech/jellybeans.vim'

" Syntax
Plugin 'wting/rust.vim'
Plugin 'cespare/vim-toml'

" Other
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdtree-git-plugin'
Plugin 'scrooloose/nerdcommenter'
Plugin 'a.vim'
Plugin 'Raimondi/delimitMate'
Plugin 'yangchenyun/Conque-Shell'
Plugin 'AutoComplPop'
Plugin 'embear/vim-localvimrc'

call vundle#end()

" Whitespace
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent

" Display
set number
set hlsearch

" Color scheme
colorscheme jellybeans

" Syntax highlighting
filetype plugin indent on
syntax on

" Behavior
"au winleave * w
set bufhidden="delete"
let bufhidden="delete"
set bufhidden=delete
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

" Keybinds
let mapleader="."
map <F1> :make<CR>

" NERDTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Localvimrc
let g:localvimrc_sandbox=0
let g:localvimrc_ask=0
