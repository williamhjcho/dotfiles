require('whjc.options')

vim.pack.add({
  -- colorschemes
  { src = 'https://github.com/navarasu/onedark.nvim' },
  -- { src = 'https://github.com/rebelot/kanagawa.nvim' },
  -- { src = 'https://github.com/folke/tokyonight.nvim' },
  { src = 'https://github.com/neovim/nvim-lspconfig' },
  { src = 'https://github.com/mason-org/mason.nvim' },

  -- editor
  { src = 'https://github.com/christoomey/vim-tmux-navigator' },
  { src = 'https://github.com/jake-stewart/multicursor.nvim' },
  { src = 'https://github.com/folke/snacks.nvim' },
  { src = 'https://github.com/folke/which-key.nvim' },
  { src = 'https://github.com/b0o/SchemaStore.nvim' },
  { src = 'https://github.com/NMAC427/guess-indent.nvim' },
  { src = 'https://github.com/lewis6991/gitsigns.nvim' },
  { src = 'https://github.com/chrisgrieser/nvim-origami' },
  { src = 'https://github.com/folke/persistence.nvim' },

  -- lsp
  { src = 'https://github.com/windwp/nvim-ts-autotag' },
}, {
  load = true,
  confirm = false,
})

local pack_plugins = vim.pack.get()

local to_delete = vim
  .iter(pack_plugins)
  :filter(function(plugin)
    return not plugin.active
  end)
  :map(function(plugin)
    return plugin.spec.name
  end)
  :totable()
if #to_delete > 0 then
  vim.pack.del(to_delete)
end

require('whjc.colorschemes')
require('whjc.keymaps')
require('whjc.autocmds')
require('whjc.lsp')

-- plugin setups
require('whjc.mason')
require('whjc.multicursor')
require('guess-indent').setup({})
require('nvim-ts-autotag').setup({})
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
require('gitsigns').setup({})
require('origami').setup({
  autoFold = { enabled = false },
})
require('persistence').setup({})

-- require('whjc.lazy')
