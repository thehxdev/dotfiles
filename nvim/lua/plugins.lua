-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use 'nvim-tree/nvim-web-devicons'
  use 'nvim-tree/nvim-tree.lua'
  use {'neoclide/coc.nvim', branch = 'release'}
  use 'ryanoasis/vim-devicons'

  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  }

  use 'jiangmiao/auto-pairs'
  use 'tpope/vim-fugitive'
  use 'ayu-theme/ayu-vim'
  use 'morhetz/gruvbox'
  use { "catppuccin/nvim", as = "catppuccin" }
  use 'Yggdroot/indentLine'
  use 'nvim-lua/plenary.nvim'
  use 'lewis6991/gitsigns.nvim'
  use 'folke/tokyonight.nvim'
  use 'EdenEast/nightfox.nvim'
  use 'folke/which-key.nvim'

  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.0',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
end)
