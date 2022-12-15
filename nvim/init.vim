if !has('gui_running') && &term =~ '^\%(screen\|tmux\)'
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

:syntax on
:filetype on
:filetype plugin indent on
:set background=dark
:colorscheme tokyonight-night
":colorscheme tokyonight
":colorscheme nightfox
"let g:lightline = {'colorscheme': 'catppuccin_mocha'}

:set clipboard=unnamedplus
:set number
:set relativenumber
:set autoindent
:set smartindent
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
:set completeopt-=preview
:set cursorline

lua require('plugins')
lua require('whichkey')
lua require('nvimtree')
lua require('telescope')
lua require('gitsigns')
lua require('treesitter')

let mapleader = " "

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
noremap <S-m> :bdelete<CR>
noremap <S-h> :bprevious<CR>
noremap <S-l> :bnext<CR>
noremap <S-j> :<CR>
noremap <leader>e :NvimTreeToggle<CR>
noremap <leader>t :terminal<CR>

" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fc <cmd>Telescope colorscheme<cr>
"nnoremap <leader>fh <cmd>Telescope help_tags<cr>

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

