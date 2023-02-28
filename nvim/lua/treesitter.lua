local configs = require("nvim-treesitter.configs")

configs.setup {
  ensure_installed = {"python", "lua", "json", "cpp", "help"},
  sync_install = false,
  ignore_install = { "" }, -- List of parsers to ignore installing
  highlight = {
    enable = true, -- false will disable the whole extension
    disable = { "" }, -- list of language that will be disabled
    additional_vim_regex_highlighting = true,

  },
  indent = { enable = true, disable = { "yaml", "python" } },
  rainbow = {
    enable = true,
    max_file_lines = nil,
  }
}
