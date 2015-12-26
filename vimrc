" Set plugins
call plug#begin('~/.vim/plugged')

" Install plugins:
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim && vim +PlugInstall

" Faaancy
Plug 'nanotech/jellybeans.vim'
"Plug 'bling/vim-airline'
Plug 'airblade/vim-gitgutter'
Plug 'Xuyuanp/nerdtree-git-plugin'

" Syntax
Plug 'wting/rust.vim'
Plug 'cespare/vim-toml'
Plug 'Glench/Vim-Jinja2-Syntax'

" Other
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'a.vim'
Plug 'Raimondi/delimitMate'
Plug 'AutoComplPop'
Plug 'embear/vim-localvimrc'
Plug 'scrooloose/syntastic'

call plug#end()

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

" Color scheme
colorscheme jellybeans

" Syntax highlighting
filetype plugin indent on
syntax on

" Behavior
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
set omnifunc=syntaxcomplete#Complete
set mouse=a
set ttyfast
set clipboard+=unnamed
set clipboard+=unnamedplus

" Keybinds
let mapleader="."
map <F1> :make<CR>
map <F12> :syntax sync fromstart<CR>

" NERDTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Localvimrc
let g:localvimrc_sandbox=0
let g:localvimrc_ask=0

" Syntastic
set statusline+=\ %#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
