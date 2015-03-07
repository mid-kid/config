set nocompatible
filetype off

" Set plugins
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

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

Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdtree-git-plugin'
Plugin 'scrooloose/nerdcommenter'
Plugin 'a.vim'
Plugin 'Raimondi/delimitMate'
Plugin 'yangchenyun/Conque-Shell'
Plugin 'AutoComplPop'

call vundle#end()

" Color scheme
colorscheme jellybeans

" Mapleader
let mapleader="."

" Whitespace
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent

" Syntax highlighting
filetype plugin indent on
syntax on

" Highlight trailing whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

" Display
set number
set hlsearch
