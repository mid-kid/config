set nocompatible
filetype off

" Set plugins
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" https://github.com/Shougo/neobundle.vim supports SVN, and may support other
"   sources in the future, such as compressed files. Maybe switch.
" Otherwise, https://github.com/MarcWeber/vim-addon-manager also looks nice,
"   but it lacks documentation.

Plugin 'gmarik/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'a.vim'
Plugin 'Raimondi/delimitMate'
Plugin 'nanotech/jellybeans.vim'
" Plugin 'file://' . $HOME . '/.vim/manual/Conque-Shell'  " https://conque.googlecode.com/files/conque_2.3.tar.gz
Plugin 'yangchenyun/Conque-Shell'
Plugin 'ervandew/supertab'

call vundle#end()

" Color scheme
colorscheme jellybeans

" Syntax highlighting
filetype plugin indent on
syntax on

" Whitespace
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent

" Highlight trailing whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

" Display
set number
set hlsearch