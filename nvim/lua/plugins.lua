-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- LSP
    -- use {'neoclide/coc.nvim', branch = 'release'}
    -- use 'neovim/nvim-lspconfig' -- Configurations for Nvim LSP
    -- use {
    --     'VonHeikemen/lsp-zero.nvim',
    --     requires = {
    --         -- LSP Support
    --         {'neovim/nvim-lspconfig'},
    --         {'williamboman/mason.nvim'},
    --         {'williamboman/mason-lspconfig.nvim'},

    --         -- Autocompletion
    --         {'hrsh7th/nvim-cmp'},
    --         {'hrsh7th/cmp-buffer'},
    --         {'hrsh7th/cmp-path'},
    --         {'saadparwaiz1/cmp_luasnip'},
    --         {'hrsh7th/cmp-nvim-lsp'},
    --         {'hrsh7th/cmp-nvim-lua'},

    --         -- Snippets
    --         {'L3MON4D3/LuaSnip'},
    --         {'rafamadriz/friendly-snippets'},
    --     }
    -- }

    use 'neovim/nvim-lspconfig' -- Collection of configurations for built-in LSP client
    use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
    use 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp
    use 'saadparwaiz1/cmp_luasnip' -- Snippets source for nvim-cmp
    use 'L3MON4D3/LuaSnip' -- Snippets plugin
    use "williamboman/mason.nvim"
    use 'williamboman/mason-lspconfig.nvim'

    -- Scala LSP
    --use({'scalameta/nvim-metals', requires = { "nvim-lua/plenary.nvim" }})

    -- Purescript support for neovim
    --use 'purescript-contrib/purescript-vim'

    -- Icons
    use 'ryanoasis/vim-devicons'
    use 'nvim-tree/nvim-web-devicons'

    -- NvimTree
    use 'nvim-tree/nvim-tree.lua'

    -- Tree-sitter
    use {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
    }

    -- Colors
    use 'ayu-theme/ayu-vim'
    use 'morhetz/gruvbox'
    use 'EdenEast/nightfox.nvim'
    use 'folke/tokyonight.nvim'
    use { "catppuccin/nvim", as = "catppuccin" }

    -- Indent indicator
    use 'Yggdroot/indentLine'
    --use "lukas-reineke/indent-blankline.nvim"

    -- Telescope
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.0',
        requires = { {'nvim-lua/plenary.nvim'} }
    }

    -- Bufferline
    use {'akinsho/bufferline.nvim', tag = "v3.*", requires = 'nvim-tree/nvim-web-devicons'}

    -- Others
    use 'jiangmiao/auto-pairs'
    use 'tpope/vim-fugitive'
    use 'nvim-lua/plenary.nvim'
    use 'lewis6991/gitsigns.nvim'
    use 'folke/which-key.nvim'

end)
