vim.pack.add({
  -- editor
  'https://github.com/folke/snacks.nvim',
  'https://github.com/folke/which-key.nvim',
  'https://github.com/b0o/SchemaStore.nvim',
  'https://github.com/folke/persistence.nvim',

  -- lsp
  'https://github.com/mfussenegger/nvim-lint',
}, {
  load = true,
  confirm = false,
})

require('whjc.autocmds')

-- plugin setups
require('snacks').setup({
  indent = { enabled = true },
  lazygit = {},
  explorer = {},
  picker = {},
})
require('which-key').setup({
  preset = 'helix',
  defaults = {},
  spec = {
    { '<leader><tab>', group = 'tabs' },
    { '<leader>b', group = 'buffer' },
    { '<leader>c', group = 'code' },
    { '<leader>d', group = 'debug' },
    { '<leader>f', group = 'file|find' },
    { '<leader>q', group = 'quit|session' },
    { '<leader>s', group = 'search' },
    { '<leader>x', group = 'diagnostics|quickfix' },
    { 'g', group = 'goto' },
    { 'gs', group = 'surround' },
    { 'z', group = 'fold' },
  },
})
require('persistence').setup({})

-- lsp setups
require('whjc.blink')
require('whjc.nvim-lint')
require('whjc.javascript')
-- require('whjc.clojure')
require('whjc.flutter')
require('whjc.ai')
require('whjc.debug')
