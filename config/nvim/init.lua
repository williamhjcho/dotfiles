require('whjc.options')

vim.pack.add({
  -- colorschemes
  'https://github.com/navarasu/onedark.nvim',
  -- 'https://github.com/rebelot/kanagawa.nvim',
  -- 'https://github.com/folke/tokyonight.nvim',
  'https://github.com/neovim/nvim-lspconfig',
  'https://github.com/mason-org/mason.nvim',

  -- editor
  'https://github.com/christoomey/vim-tmux-navigator',
  'https://github.com/jake-stewart/multicursor.nvim',
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter', version = 'main' },
  'https://github.com/folke/snacks.nvim',
  'https://github.com/folke/which-key.nvim',
  -- end
  'https://github.com/b0o/SchemaStore.nvim',
  'https://github.com/NMAC427/guess-indent.nvim',
  'https://github.com/lewis6991/gitsigns.nvim',
  'https://github.com/chrisgrieser/nvim-origami',
  'https://github.com/folke/persistence.nvim',
  'https://github.com/echasnovski/mini.nvim',
  'https://github.com/MagicDuck/grug-far.nvim',
  'https://github.com/folke/todo-comments.nvim',

  -- lsp
  'https://github.com/stevearc/conform.nvim',
  'https://github.com/folke/ts-comments.nvim',
  'https://github.com/windwp/nvim-ts-autotag',
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
require('whjc.treesitter')
require('whjc.multicursor')
require('whjc.mini')
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
require('ts-comments').setup({})
require('persistence').setup({})
require('grug-far').setup({
  headerMaxWidth = 80,
})
require('todo-comments').setup({
  -- event = 'VimEnter',
  -- dependencies = { 'nvim-lua/plenary.nvim' },
  signs = false,
})

-- editor plugins
require('whjc.conform')
-- require('whjc.lazy')
