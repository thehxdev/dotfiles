return {
    {
        "ellisonleao/gruvbox.nvim",
        priority = 1000,
        opts = {
            transparent_mode = false,
            italic = {
                strings = false,
                emphasis = true,
                comments = true,
                operators = false,
                folds = true,
            },
            inverse = true,
        },
    },
    {
        "folke/tokyonight.nvim",
        priority = 1000,
        opts = {
            style = "night",
            transparent = true,
            styles = {
                comments = { italic = true },
                keywords = { italic = true },
                sidebars = "transparent",
                floats = "dark",
            },
        },
    },
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        opts = {
            flavour = "mocha",
            transparent_background = false,
            styles = {
                comments = { "italic" },
                conditionals = { "italic" },
            },
        },
    },
}
