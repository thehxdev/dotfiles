return {
    "numToStr/Comment.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
        ignore = "^$",
        mappings = {
            basic = true,
        },
    },
    -- lazy = false,
}
