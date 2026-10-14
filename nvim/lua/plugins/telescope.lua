return {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = "Telescope",
    keys = {
        { "<leader>.", "<cmd>Telescope find_files<cr>", desc = "Find files" },
        { "<leader>fb", "<cmd>Telescope buffers show_all_buffers=true<cr>", desc = "Switch Buffer" },
        { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Grep" },
        { "<leader>fc", "<cmd>Telescope colorscheme<cr>", desc = "Switch colorscheme" },
        { "<leader>fo", "<cmd>Telescope oldfiles<cr>", desc = "Recent files" },
        { "<leader>ft", "<cmd>Telescope tags<cr>", desc = "Tags" },
    },
    opts = {
        defaults = {
            prompt_prefix = " ",
            selection_caret = " ",
            path_display = { "smart" },
        },
    },
}
