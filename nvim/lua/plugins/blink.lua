return {
    "saghen/blink.cmp",
    version = "1.*",
    dependencies = { "rafamadriz/friendly-snippets" },
    opts = {
        keymap = { preset = "enter" },
        appearance = {
            nerd_font_variant = "normal",
        },
        completion = {
            documentation = { auto_show = false },
        },
        sources = {
            default = { "lsp", "path", "snippets", "buffer" },
            providers = {
                lsp = { fallbacks = {} },
            },
        },
        fuzzy = { implementation = "prefer_rust_with_warning" },
    },
    opts_extend = { "sources.default" },
}
