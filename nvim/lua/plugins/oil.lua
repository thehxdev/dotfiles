return {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
        { "<leader>e", "<cmd>Oil<cr>", desc = "Toggle Oil" },
    },
    opts = {
        float = {
            border = "rounded",
        },
        confirmation = {
            border = "rounded",
        },
        progress = {
            border = "rounded",
        },
        keymaps_help = {
            border = "rounded",
        },
    },
}
