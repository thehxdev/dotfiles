require('mason.settings').set({
  ui = {
    border = 'rounded'
  }
})

-- ################################# --
-- CCLS (C, C++, objC)
local lspconfig = require('lspconfig')
lspconfig.ccls.setup {
  init_options = {
    cache = {
      directory = ".ccls-cache";
    }
  }
}

-- ################################# --

local lsp = require('lsp-zero')

lsp.preset('recommended')

lsp.ensure_installed({
  'pyright',
  'sumneko_lua',
})

lsp.set_preferences({
  suggest_lsp_servers = true,
  setup_servers_on_start = true,
  set_lsp_keymaps = true,
  configure_diagnostics = true,
  cmp_capabilities = true,
  manage_nvim_cmp = true,
  call_servers = 'local',
  sign_icons = {
    error = '✘',
    warn = '▲',
    hint = '⚑',
    info = ''
  }
})

lsp.setup_nvim_cmp({
  sources = {
    { name = 'nvim_lsp', keyword_length = 1 },
    { name = 'buffer', keyword_length = 1 },
    { name = 'path' },
  },
})

lsp.setup()

-- ################################# --

local cmp = require('cmp')

local cmp_config = lsp.defaults.cmp_config({
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  }
})

cmp.setup(cmp_config)

