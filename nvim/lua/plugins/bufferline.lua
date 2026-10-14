return {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    keys = {
        { "<leader>bp", "<cmd>BufferLineTogglePin<cr>", desc = "Toggle pin" },
        { "<leader>bP", "<cmd>BufferLineGroupClose ungrouped<cr>", desc = "Delete non-pinned buffers" },
    },
    opts = {
        options = {
            close_command = function(n) vim.cmd.bdelete(n) end,
            right_mouse_command = function(n) vim.cmd.bdelete(n) end,
            diagnostics = "nvim_lsp",
            always_show_bufferline = false,
        },
    },
}
