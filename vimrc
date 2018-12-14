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
"Plug 'abudden/taghighlight-automirror'

" Syntax
Plug 'rust-lang/rust.vim'
Plug 'cespare/vim-toml'
Plug 'Glench/Vim-Jinja2-Syntax'
Plug 'PotatoesMaster/i3-vim-syntax'
Plug 'lervag/vimtex'
Plug 'zah/nim.vim'

" Project management
Plug 'scrooloose/nerdtree'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'embear/vim-localvimrc'
Plug 'ludovicchabant/vim-gutentags'

" Editing
Plug 'scrooloose/nerdcommenter'
Plug 'Raimondi/delimitMate'
Plug 'vim-scripts/AutoComplPop'
Plug 'tpope/vim-surround'
Plug 'junegunn/vim-easy-align'
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
set listchars=tab:>-,space:·

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
map <C-n> :noh<CR>
map <C-w> :set invlist<CR>
map <C-o> :NERDTreeToggle<CR>
map <leader>. :CtrlPTag<CR>

nnoremap <C-h> <C-w><C-h>
nnoremap <C-j> <C-w><C-j>
nnoremap <C-k> <C-w><C-k>
nnoremap <C-l> <C-w><C-l>

" CtrlP
let g:ctrlp_map='<C-p>'
let g:ctrlp_prompt_mappings={
  \ 'AcceptSelection("h")': ['<C-i>'],
  \ 'AcceptSelection("v")': ['<C-x>'],
  \ }
let g:ctrlp_working_path_mode='a'

" NERDTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
let g:NERDTreeQuitOnOpen=1

" NERDCommenter
let g:NERDAltDelims_c=1
let g:NERDCustomDelimiters={'rgbds': {'left': ';', 'right': ''}}

" Localvimrc
let g:localvimrc_sandbox=0
let g:localvimrc_count=1
let g:localvimrc_persistent=1
let g:localvimrc_persistence_file=$HOME."/.vim/.localvimrc_persistent"

" Gutentags
set statusline+=%{gutentags#statusline()}
set tags=.tags
let g:gutentags_ctags_tagfile='.tags'
let g:gutentags_project_root=['.tags']
let g:gutentags_add_default_project_roots=0
let g:ctrlp_root_markers=['.tags']

" Taghighlight
let g:TagHighlightSettings={'TagFileName': '.tags'}
