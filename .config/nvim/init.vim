" _       _ _         _
"(_)_ __ (_) |___   _(_)_ __ ___
"| | '_ \| | __\ \ / / | '_ ` _ \
"| | | | | | |_ \ V /| | | | | | |
"|_|_| |_|_|\__(_)_/ |_|_| |_| |_|
"

let mapleader = ' '

if ! filereadable(stdpath('config') . '/autoload/plug.vim')
	echo "Downloading junegunn/vim-plug to manage plugins..."
	if has('win32')
		silent execute '!mkdir ' . stdpath('config') . '\autoload'
	else
		silent execute '!mkdir -p ' . stdpath('config') . '/autoload'
	endif
	silent execute '!curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ' . stdpath('config') . '/autoload/plug.vim'
	autocmd VimEnter * PlugInstall
endif

syntax on
filetype plugin on

set tabstop=4
set softtabstop=4

set noerrorbells
set smartindent
set smarttab
set expandtab
set rnu nu
set nowrap
let &undodir=stdpath('data') . '/undo'
set undofile
set noswapfile
set nobackup
set incsearch
set smartcase

set colorcolumn=81
highlight ColorColumn ctermbg=0 guibg=lightgrey

call plug#begin(stdpath('data') . '/plugged')

Plug 'morhetz/gruvbox'
Plug 'preservim/nerdtree'
Plug 'tomasiser/vim-code-dark'
Plug 'jremmen/vim-ripgrep'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'vim-utils/vim-man'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'tpope/vim-sleuth'
"Plug 'ycm-core/YouCompleteMe'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ap/vim-css-color'
Plug 'PotatoesMaster/i3-vim-syntax'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

call plug#end()
" Function for mapping everywhere
function! MapBoth(keys, rhs)
	execute 'nmap' a:keys a:rhs
	execute 'imap' a:keys '<esc>' . a:rhs . 'a'
endfunction

" set termguicolors
colorscheme codedark
set background=dark

let g:airline#extension#tabline#enabled = 1
let g:airline#extensions#coc#enabled = 1

" Automatically deletes all trailing whitespace and newlines at end of file on save.
autocmd BufWritePre * %s/\s\+$//e
autocmd BufWritepre * %s/\n\+\%$//e

" Basics
nnoremap c "_c
set mouse=a
set go=a
set nohlsearch

" Nerd Tree
map <leader>n :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let NERDTreeBookmarksFile = stdpath('data') . '/NERDTreeBookmarks'

" Save file as sudo on files that require root permission
cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

" Splits open at the bottom and right, which is non-retarded, unlike vim defaults.
set splitbelow splitright

" Disables automatic commenting on newline:
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Enable autocompletion:
set wildmode=longest,list,full

" Autoenter limelight mode when going into goyo mode & bindings
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!
let g:limelight_conceal_ctermfg = 'DarkGrey'

" Enable autocompletion:
set wildmode=longest,list,full

" Goyo & Limelight mode enter
map <Leader>z :Goyo<CR>

" Enter paste mode
"nmap <F2> :set paste!<CR>
"imap <F2> <esc>:set paste!<CR>a
call MapBoth('<F2>', ':set paste!<CR>')

" Shortcutting split navigation, saving a keypress:
map <Leader>h <C-w>h
map <Leader>j <C-w>j
map <Leader>k <C-w>k
map <Leader>l <C-w>l

" Shortcutting tab navigation, saving a keypress:
map <C-j> :tabprev<CR>
map <C-k> :tabnext<CR>

" Markdown & MD Preview
nmap <Leader>p <Plug>MarkdownPreviewToggle
autocmd FileType markdown let b:sleuth_automatic=0
autocmd FileType markdown set conceallevel=0
autocmd FileType markdown normal zR

" Resize splits
nnoremap <silent> <Leader>+ :exe "resize " . (winheight(0) * 1/2)<CR>
nnoremap <silent> <Leader>- :exe "resize " . (winheight(0) * 1/3)<CR>

nnoremap <Leader><F3> :execute ':tabedit! ' . stdpath("config") . '/init.vim'<CR>
