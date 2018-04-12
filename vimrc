" Install plugins (vim):
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim && vim +PlugInstall
" Install plugins (neovim):
" curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim && nvim +PlugInstall
"
" Create backup directories (vim):
" mkdir -p ~/.vim/.backup ~/.vim/.swp ~/.vim/.undo

" Set plugins
call plug#begin('~/.vim/plugged')

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
Plug 'chrisbra/vim-diff-enhanced'

call plug#end()

" Files and folders
set undodir=~/.vim/.undo//
set backupdir=~/.vim/.backup//
set directory=~/.vim/.swp//

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
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/  " ExtraWhitespace is defined in the theme

" Behavior
set omnifunc=syntaxcomplete#Complete
set mouse=a
set ttyfast
set clipboard=unnamed
set clipboard+=unnamedplus
set backup
set undofile

" Keybinds
let mapleader=";"
let maplocalleader=";"
map <F1> :make<CR>
map <F8> :!curl -T % chunk.io 2> /dev/null<CR>
map <F12> :syntax sync fromstart<CR>
map <F11> :SyntasticToggleMode<CR>
map <C-n> :noh<CR>
map <C-p> :NERDTreeToggle<CR>

nnoremap <C-h> <C-w><C-h>
nnoremap <C-j> <C-w><C-j>
nnoremap <C-k> <C-w><C-k>
nnoremap <C-l> <C-w><C-l>

" NERDTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
let g:NERDTreeQuitOnOpen=1

" NERDCommenter
let g:NERDAltDelims_c=1

" Localvimrc
let g:localvimrc_sandbox=0
let g:localvimrc_count=1
let g:localvimrc_persistent=1
let g:localvimrc_persistence_file=$HOME."/.vim/.localvimrc_persistent"
