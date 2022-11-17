syntax enable
filetype on
filetype plugin indent on
set background=dark
colorscheme solarized

set relativenumber
set autoindent
set tabstop=4
set shiftwidth=4
set smarttab
set softtabstop=4
set mouse=a
set termguicolors
set encoding=UTF-8
set nocompatible
set completeopt-=preview " For No Previews
let g:solarized_termcolors=256

call plug#begin()

Plug 'ericbn/vim-solarized'
Plug 'sheerun/vim-polyglot'
Plug 'vim-python/python-syntax'
Plug 'https://github.com/preservim/nerdtree' " NerdTree
Plug 'https://github.com/neoclide/coc.nvim'  " Auto Completion
Plug 'https://github.com/ryanoasis/vim-devicons' " Developer Icons
Plug 'https://github.com/tc50cal/vim-terminal' " Vim Terminal
Plug 'https://github.com/terryma/vim-multiple-cursors' " CTRL + N for multiple cursors
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

call plug#end()

let mapleader = " "
"set timeoutlen 500

"noremap <C-f> :NERDTreeFocus<CR>
"noremap <C-n> :NERDTree<CR>
noremap <C-e> :NERDTreeToggle<CR>
noremap <g-d> :call CocActionAsync('jumpDefinition')<CR>
noremap <leader>e :NERDTreeToggle<CR>
noremap <leader>f :Files<CR>
noremap <leader>b :Buffers<CR>
noremap <leader>c :Colors<CR>
noremap <leader>h :History<CR>

inoremap <expr> <Return> pumvisible() ? coc#_select_confirm() : "<Return>"
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<C-h>"

" Python
let g:python_highlight_all = 1
let g:python_highlight_indent_errors = 1

