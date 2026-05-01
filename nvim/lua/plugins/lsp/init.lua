return {
    -- nvim-lspconfig
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "mason.nvim",
            { "mason-org/mason-lspconfig.nvim", config = function() end },
        },
        config = function ()
            -- if true then
            --     return
            -- end

            local lsp = vim.lsp
            local diagnostic = vim.diagnostic

            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(args)
                    local client = vim.lsp.get_client_by_id(args.data.client_id)
                    if not client then
                        return
                    end

                    local keymap = vim.keymap.set
                    local opts = { noremap=true, silent=true }
                    keymap('n', 'gl', diagnostic.open_float, opts)
                    keymap('n', 'gL', diagnostic.setloclist, opts)
                    keymap('n', 'gd', lsp.buf.definition, opts)
                    keymap('n', 'gD', lsp.buf.declaration, opts)

                    -- disable lsp server's syntax highlighting
                    client.server_capabilities.semanticTokensProvider = nil
                end,
            })

            diagnostic.config({
                float = { border="rounded", },
                -- This line will disable inline diagnostics
                virtual_text = false
            })
            -- disable diagnostics to be able to focus :)
            diagnostic.enable(false)

            lsp.config('*', {
                capabilities = require('blink.cmp').get_lsp_capabilities(capabilities),
            })

            -- add enabled language servers here
            local enabled_servers = {
                "gopls",
                "clangd",
                "lua_ls",
                "zls",
                -- "rust_analyzer",
            }
            for _, s in ipairs(enabled_servers) do
                lsp.enable(s)
            end


            -----
            -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md
            -----

            -- rust
            lsp.config('rust_analyzer', {
                cmd = {
                    -- "rustup", "run", "nightly", "rust-analyzer"
                    "rustup", "run", "stable", "rust-analyzer"
                },
            })

            lsp.config('lua_ls', {
                settings = { Lua = {} },
                on_init = function(client)
                    if client.workspace_folders then
                        local path = client.workspace_folders[1].name
                        if
                            path ~= vim.fn.stdpath('config')
                            and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc'))
                        then
                            return
                        end
                    end

                    client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
                        runtime = {
                            -- Tell the language server which version of Lua you're using (most
                            -- likely LuaJIT in the case of Neovim)
                            version = 'LuaJIT',
                            -- Tell the language server how to find Lua modules same way as Neovim
                            -- (see `:h lua-module-load`)
                            path = {
                                'lua/?.lua',
                                'lua/?/init.lua',
                            },
                        },
                        -- Make the server aware of Neovim runtime files
                        workspace = {
                            checkThirdParty = false,
                            library = {
                                vim.env.VIMRUNTIME
                            }
                        }
                    })
                end,
            })

            -- javascript / typescript
            -- lsp.config('tsserver', {
            --     cmd = { "bunx", "typescript-language-server", "--stdio" },
            --     filetypes = { 'javascript', 'typescript' },
            -- })

            -- java
            -- to use jdtls, install it first
            -- https://github.com/eclipse/eclipse.jdt.ls#installation
            -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#jdtls
            -- NOTE: Point `-data` to parent directory of your java projects and put /workspace in front of it.
            --
            -- lsp.config('jdtls', {
            --     cmd = { '/home/hx/opt/jdtls/bin/jdtls', '-data', '/home/hx/projects/java/workspace' },
            --     filetypes = { 'java' },
            -- })

            -- ocaml
            -- lsp.config('ocamllsp', {
            --    cmd = { "/home/hx/.opam/default/bin/ocamllsp" },
            -- })
        end
    },

    -- Mason
    {
        "mason-org/mason.nvim",
        cmd = "Mason",
        keys = { { "<leader>m", "<cmd>Mason<cr>", desc = "Mason" } },
        build = ":MasonUpdate",
        opts = {
            ensure_installed = {},
        },
        ---@param opts MasonSettings | {ensure_installed: string[]}
        config = function(_, opts)
            require("mason").setup(opts)
            local mr = require("mason-registry")
            local function ensure_installed()
                for _, tool in ipairs(opts.ensure_installed) do
                    local p = mr.get_package(tool)
                    if not p:is_installed() then
                        p:install()
                    end
                end
            end
            if mr.refresh then
                mr.refresh(ensure_installed)
            else
                ensure_installed()
            end
        end,
    }
}
