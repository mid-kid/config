" Set plugins
call plug#begin('~/.vim/plugged')

" Install plugins (vim):
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim && vim +PlugInstall
" Install plugins (neovim):
" curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim && nvim +PlugInstall

" Faaancy
Plug 'junegunn/seoul256.vim'
"Plug 'nanotech/jellybeans.vim'
"Plug 'bling/vim-airline'
Plug 'airblade/vim-gitgutter'
Plug 'Xuyuanp/nerdtree-git-plugin'

" Syntax
Plug 'rust-lang/rust.vim'
Plug 'cespare/vim-toml'
Plug 'Glench/Vim-Jinja2-Syntax'

" Other
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'Raimondi/delimitMate'
Plug 'AutoComplPop'
Plug 'embear/vim-localvimrc'
"Plug 'scrooloose/syntastic'

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
let g:seoul256_background = 233
colorscheme seoul256

" Syntax highlighting
filetype plugin indent on
syntax on

" Behavior
highlight ExtraWhitespace ctermbg=red guibg=#592929
match ExtraWhitespace /\s\+$/
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
set omnifunc=syntaxcomplete#Complete
set mouse=a
set ttyfast
set clipboard+=unnamed
set clipboard+=unnamedplus

" Keybinds
let mapleader="."
map <F1> :make<CR>
map <F8> :!curl -T % chunk.io 2> /dev/null<CR>
map <F12> :syntax sync fromstart<CR>
map <F11> :SyntasticToggleMode<CR>
map <C-m> :noh<CR>
map <C-o> :match OverLength /\%81v.\+/<CR>
map <C-z><C-o> :match OverLength //<CR>

" NERDTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Localvimrc
let g:localvimrc_sandbox=0
let g:localvimrc_ask=0

" Syntastic
"set statusline+=\ %#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0
