if !has('gui_running') && &term =~ '^\%(screen\|tmux\)'
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

":syntax on
":filetype on
":filetype plugin indent on
:set background=dark
:colorscheme catppuccin_mocha
"let g:onedark_terminal_italics=1
"let g:onedark_termcolors=256
let g:lightline = {'colorscheme': 'catppuccin_mocha'}

:set clipboard=unnamedplus
:set number
:set relativenumber
:set autoindent
:set expandtab
:set tabstop=4
:set shiftwidth=4
:set softtabstop=4
:set nobackup
:set smarttab
:set scrolloff=4
:set nowrap
:set incsearch
:set mouse=a
:set ignorecase
:set termguicolors
:set showmatch
:set hlsearch
:set encoding=UTF-8
:set wildmenu
:set wildmode=list:full
:set nocompatible
:set completeopt-=preview " For No Previews
:set cursorline

call plug#begin()

Plug 'http://github.com/tpope/vim-surround' " Surrounding ysw)
Plug 'https://github.com/preservim/nerdtree' " NerdTree
Plug 'https://github.com/neoclide/coc.nvim'  " Auto Completion
Plug 'https://github.com/ryanoasis/vim-devicons' " Developer Icons
Plug 'https://github.com/tc50cal/vim-terminal' " Vim Terminal
Plug 'https://github.com/terryma/vim-multiple-cursors' " CTRL + N for multiple cursors
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-fugitive'
Plug 'ayu-theme/ayu-vim'
Plug 'joshdick/onedark.vim'
Plug 'morhetz/gruvbox'
Plug 'catppuccin/vim'

call plug#end()

let mapleader = " "

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
noremap <C-e> :NERDTreeToggle<CR>
noremap <S-m> :bdelete<CR>
noremap <S-h> :bprevious<CR>
noremap <S-l> :bnext<CR>
noremap <S-j> :<CR>
noremap <leader>e :NERDTreeToggle<CR>
noremap <leader>f :Files<CR>
noremap <leader>b :Buffers<CR>
noremap <leader>c :Colors<CR>
noremap <leader>h :History<CR>
noremap <leader>t :terminal<CR>

inoremap <expr> <Tab> coc#pum#visible() ? coc#pum#next(1) : "\<Tab>"
inoremap <expr> <S-Tab> coc#pum#visible() ? coc#pum#prev(1) : "\<S-Tab>"
inoremap <expr> <Return> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"

:set completeopt-=preview " For No Previews


let g:NERDTreeDirArrowExpandable="+"
let g:NERDTreeDirArrowCollapsible="~"

" Status
" Clear status line when vimrc is reloaded.
set statusline=

" Status line left side.
set statusline+=\ %F\ %M\ %Y\ %R

" Use a divider to separate the left side from the right side.
set statusline+=%=

" Status line right side.
"set statusline+=\ ascii:\ %b\ hex:\ 0x%B\ row:\ %l\ col:\ %c\ percent:\ %p%%
set statusline+=\ row:\ %l\ col:\ %c\ percent:\ %p%%

" Show the status on the second to last line.
set laststatus=2

if has("nvim-0.5.0")
    "nvim-treesitter configuration
lua<<EOF
local configs = require("nvim-treesitter.configs")

configs.setup {
  ensure_installed = "python",
  sync_install = false,
  ignore_install = { "" }, -- List of parsers to ignore installing
  highlight = {
    enable = true, -- false will disable the whole extension
    disable = { "" }, -- list of language that will be disabled
    additional_vim_regex_highlighting = true,

  },
  indent = { enable = true, disable = { "yaml" } },
  rainbow = {
    enable = true,
    max_file_lines = nil,
  }
}
EOF
end
