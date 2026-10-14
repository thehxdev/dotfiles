return {
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "mason.nvim",
            { "mason-org/mason-lspconfig.nvim", config = function() end },
        },
        config = function()
            local lsp = vim.lsp
            local diagnostic = vim.diagnostic

            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(args)
                    local client = vim.lsp.get_client_by_id(args.data.client_id)
                    if not client then
                        return
                    end

                    local set = vim.keymap.set
                    local buf = { buffer = args.buf, silent = true }

                    set("n", "gl", diagnostic.open_float, vim.tbl_extend("force", buf, { desc = "Line diagnostics" }))
                    set("n", "gL", diagnostic.setloclist, vim.tbl_extend("force", buf, { desc = "Diagnostics loclist" }))
                    set("n", "gd", lsp.buf.definition, vim.tbl_extend("force", buf, { desc = "Goto definition" }))
                    set("n", "gD", lsp.buf.declaration, vim.tbl_extend("force", buf, { desc = "Goto declaration" }))

                    -- disable lsp server's semantic tokens
                    client.server_capabilities.semanticTokensProvider = nil
                end,
            })

            diagnostic.config({
                float = { border = "rounded" },
                virtual_text = false,
            })
            diagnostic.enable(false)

            lsp.config("*", {
                capabilities = require("blink.cmp").get_lsp_capabilities(),
            })

            local enabled_servers = {
                "gopls",
                "clangd",
                "lua_ls",
                "zls",
                "rust_analyzer"
            }
            for _, s in ipairs(enabled_servers) do
                lsp.enable(s)
            end

            lsp.config("rust_analyzer", {
                cmd = { "rustup", "run", "stable", "rust-analyzer" },
            })

            lsp.config("lua_ls", {
                settings = { Lua = {} },
                on_init = function(client)
                    if client.workspace_folders then
                        local path = client.workspace_folders[1].name
                        if
                            path ~= vim.fn.stdpath("config")
                            and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc"))
                        then
                            return
                        end
                    end

                    client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
                        runtime = {
                            version = "LuaJIT",
                            path = { "lua/?.lua", "lua/?/init.lua" },
                        },
                        workspace = {
                            checkThirdParty = false,
                            library = { vim.env.VIMRUNTIME },
                        },
                    })
                end,
            })
        end,
    },

    {
        "mason-org/mason.nvim",
        cmd = "Mason",
        keys = { { "<leader>m", "<cmd>Mason<cr>", desc = "Mason" } },
        build = ":MasonUpdate",
        opts = {
            ensure_installed = {},
        },
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
    },
}
