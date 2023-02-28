local lspconfig = require('lspconfig')

local opts = { noremap=true, silent=true }
vim.keymap.set('n', 'gl', vim.diagnostic.open_float, opts)
vim.keymap.set('n', 'gL', vim.diagnostic.setloclist, opts)

local on_attach = function(client, bufnr)
    local bufopts = { noremap=true, silent=true, buffer=bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
end

local lsp_flags = {
    debounce_text_changes = 150,
}

-----
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
-----

-- python
lspconfig.pyright.setup {
    on_attach = on_attach,
    flags = lsp_flags,
}

-- bash
lspconfig.bashls.setup{}

-- lua
lspconfig.lua_ls.setup {
    on_attach = on_attach,
    flags = lsp_flags,
}

-- C / C++ / Obj-C
lspconfig.ccls.setup {
  init_options = {
    cache = {
      directory = ".ccls-cache";
    };
  }
}

-- json
lspconfig.jsonls.setup{}

-- haskell
-- lspconfig.hls.setup{
--     filetypes = { 'haskell', 'lhaskell', 'cabal' },
-- }

-- zig
-- require'lspconfig'.zls.setup{}

-- javascript / typescript
-- lspconfig.tsserver.setup {
--     on_attach = on_attach,
--     flags = lsp_flags,
-- }

-- rust
-- lspconfig.rust_analyzer.setup {
--     on_attach = on_attach,
--     flags = lsp_flags,
--     settings = {
--         ["rust-analyzer"] = {}
--     }
-- }

