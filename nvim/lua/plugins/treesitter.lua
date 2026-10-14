return {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    config = function()
        local ts = require("nvim-treesitter")
        ts.setup()
        ts.install({
            "c",
            "lua",
            "vim",
            "vimdoc",
            "query",
            "markdown",
            "markdown_inline",
            "bash",
            "python",
            "rust",
            "go",
            "zig",
            "json",
            "toml",
            "yaml",
        })

        vim.api.nvim_create_autocmd("FileType", {
            desc = "Start Treesitter highlighting",
            callback = function(args)
                pcall(vim.treesitter.start, args.buf)
            end,
        })
    end,
}
